package com.tahatec.sim_card_info

import android.Manifest
import android.app.AppOpsManager
import android.app.usage.NetworkStatsManager
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.LinkProperties
import android.net.NetworkCapabilities
import android.net.Uri
import android.os.Build
import android.os.Process
import android.provider.Settings
import android.telephony.CellInfo
import android.telephony.CellInfoCdma
import android.telephony.CellInfoGsm
import android.telephony.CellInfoLte
import android.telephony.CellInfoNr
import android.telephony.CellInfoTdscdma
import android.telephony.CellInfoWcdma
import android.telephony.CellIdentityNr
import android.telephony.CellSignalStrength
import android.telephony.CellSignalStrengthCdma
import android.telephony.CellSignalStrengthGsm
import android.telephony.CellSignalStrengthLte
import android.telephony.CellSignalStrengthNr
import android.telephony.CellSignalStrengthTdscdma
import android.telephony.CellSignalStrengthWcdma
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager
import android.telephony.euicc.EuiccManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Calendar

/// The app's own telephony bridge.
///
/// Written in-tree rather than pulled from a plugin because no maintained
/// plugin exposes the full set together: per-subscription carrier ids,
/// eSIM/port info, default-subscription roles, per-radio signal strengths,
/// serving/neighbour cell identities and the connectivity link properties.
/// Every read that can throw SecurityException (values gated on
/// READ_PHONE_STATE / READ_PHONE_NUMBERS / ACCESS_FINE_LOCATION) is wrapped,
/// so a denied permission degrades to nulls instead of crashing.
class MainActivity : FlutterActivity() {
    private companion object {
        const val CHANNEL = "com.tahatec.sim_card_info/telephony"
        const val PHONE_PERMISSION_REQUEST = 4471
        const val LOCATION_PERMISSION_REQUEST = 4472
    }

    private val pendingPermissionResults = mutableMapOf<Int, MethodChannel.Result>()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkPermissions" -> result.success(permissionStates())
                "requestPermissions" -> requestRuntimePermissions(
                    result,
                    PHONE_PERMISSION_REQUEST,
                    arrayOf(
                        Manifest.permission.READ_PHONE_STATE,
                        Manifest.permission.READ_PHONE_NUMBERS,
                    ),
                )
                "requestLocationPermission" -> requestRuntimePermissions(
                    result,
                    LOCATION_PERMISSION_REQUEST,
                    arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                )
                "openAppSettings" -> {
                    startActivity(
                        Intent(
                            Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                            Uri.fromParts("package", packageName, null),
                        ),
                    )
                    result.success(null)
                }
                "openSystemScreen" -> {
                    openSystemScreen(call.argument<String>("screen") ?: "")
                    result.success(null)
                }
                "openUsageAccessSettings" -> {
                    try {
                        startActivity(Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS))
                    } catch (error: ActivityNotFoundException) {
                        startActivity(Intent(Settings.ACTION_SETTINGS))
                    }
                    result.success(null)
                }
                "getOverview" -> result.success(overview())
                "getSignal" -> result.success(signalSnapshot())
                "getCellTowers" -> cellTowers(result)
                "getDataUsage" -> result.success(dataUsage())
                "refreshWidget" -> {
                    SimInfoWidget.refreshAll(this)
                    result.success(null)
                }
                // Keeps the Android 13+ per-app language setting in sync with
                // the in-app picker, so system Settings shows the same choice.
                // The Dart-side preference stays authoritative; this is a
                // one-way mirror and a no-op below API 33.
                "setAppLocales" -> {
                    if (Build.VERSION.SDK_INT >= 33) {
                        val tag = call.argument<String>("tag") ?: ""
                        val localeManager =
                            getSystemService(android.app.LocaleManager::class.java)
                        localeManager?.applicationLocales = if (tag.isEmpty()) {
                            android.os.LocaleList.getEmptyLocaleList()
                        } else {
                            android.os.LocaleList.forLanguageTags(tag)
                        }
                    }
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    // --- permissions -------------------------------------------------------

    private fun hasPermission(name: String): Boolean =
        ContextCompat.checkSelfPermission(this, name) == PackageManager.PERMISSION_GRANTED

    private fun permissionStates(): Map<String, Any> = mapOf(
        "phoneState" to hasPermission(Manifest.permission.READ_PHONE_STATE),
        "phoneNumbers" to hasPermission(Manifest.permission.READ_PHONE_NUMBERS),
        "location" to hasPermission(Manifest.permission.ACCESS_FINE_LOCATION),
        "usageAccess" to hasUsageAccess(),
        // Lets Dart tell "denied once" apart from "denied forever": after a
        // permanent denial the rationale flag is false while the permission is
        // still missing, and the only way forward is the app settings screen.
        "showRationale" to ActivityCompat.shouldShowRequestPermissionRationale(
            this, Manifest.permission.READ_PHONE_STATE,
        ),
        "showLocationRationale" to ActivityCompat.shouldShowRequestPermissionRationale(
            this, Manifest.permission.ACCESS_FINE_LOCATION,
        ),
    )

    private fun requestRuntimePermissions(
        result: MethodChannel.Result,
        requestCode: Int,
        permissions: Array<String>,
    ) {
        if (permissions.all { hasPermission(it) }) {
            result.success(permissionStates())
            return
        }
        // A second in-flight request would orphan the first result; answer the
        // old one with the current state instead of leaking it.
        pendingPermissionResults.remove(requestCode)?.success(permissionStates())
        pendingPermissionResults[requestCode] = result
        ActivityCompat.requestPermissions(this, permissions, requestCode)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        pendingPermissionResults.remove(requestCode)?.success(permissionStates())
    }

    // --- the overview payload ---------------------------------------------

    private fun overview(): Map<String, Any?> = mapOf(
        "permissions" to permissionStates(),
        "sims" to simCards(),
        "device" to deviceInfo(),
        "connectivity" to connectivityInfo(),
    )

    private fun simCards(): List<Map<String, Any?>> {
        if (!hasPermission(Manifest.permission.READ_PHONE_STATE)) return emptyList()
        val sm = getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
        val subs: List<SubscriptionInfo> =
            runCatching { sm.activeSubscriptionInfoList }.getOrNull() ?: emptyList()
        return subs.map { si -> simCard(sm, si) }
    }

    private fun simCard(sm: SubscriptionManager, si: SubscriptionInfo): Map<String, Any?> {
        val subId = si.subscriptionId
        val tm = (getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager)
            .createForSubscriptionId(subId)

        val mcc: String?
        val mnc: String?
        if (Build.VERSION.SDK_INT >= 29) {
            mcc = si.mccString
            mnc = si.mncString
        } else {
            @Suppress("DEPRECATION")
            mcc = si.mcc.takeIf { it > 0 }?.toString()
            @Suppress("DEPRECATION")
            mnc = si.mnc.takeIf { it >= 0 }?.toString()
        }

        val number: String? = runCatching {
            if (Build.VERSION.SDK_INT >= 33) {
                sm.getPhoneNumber(subId).takeIf { it.isNotBlank() }
            } else {
                @Suppress("DEPRECATION")
                si.number?.takeIf { it.isNotBlank() }
            }
        }.getOrNull()

        return mapOf(
            "subscriptionId" to subId,
            "slotIndex" to si.simSlotIndex,
            "displayName" to si.displayName?.toString(),
            "carrierName" to si.carrierName?.toString(),
            "countryIso" to si.countryIso?.takeIf { it.isNotBlank() },
            "mcc" to mcc,
            "mnc" to mnc,
            "number" to number,
            "isEmbedded" to if (Build.VERSION.SDK_INT >= 28) si.isEmbedded else null,
            "isOpportunistic" to if (Build.VERSION.SDK_INT >= 29) si.isOpportunistic else null,
            "portIndex" to if (Build.VERSION.SDK_INT >= 33) si.portIndex else null,
            "cardId" to if (Build.VERSION.SDK_INT >= 29) si.cardId else null,
            "isDefaultData" to (subId == SubscriptionManager.getDefaultDataSubscriptionId()),
            "isDefaultVoice" to (subId == SubscriptionManager.getDefaultVoiceSubscriptionId()),
            "isDefaultSms" to (subId == SubscriptionManager.getDefaultSmsSubscriptionId()),
            // Per-subscription TelephonyManager values. Each is independently
            // guarded: a carrier-privileged or permission-gated read returning
            // null must not take the rest of the card with it.
            "simState" to runCatching { tm.simState }.getOrNull(),
            "simOperator" to runCatching { tm.simOperator.takeIf { it.isNotBlank() } }.getOrNull(),
            "simOperatorName" to runCatching { tm.simOperatorName.takeIf { it.isNotBlank() } }.getOrNull(),
            "carrierId" to if (Build.VERSION.SDK_INT >= 28) {
                runCatching { tm.simCarrierId.takeIf { it != TelephonyManager.UNKNOWN_CARRIER_ID } }.getOrNull()
            } else null,
            "carrierIdName" to if (Build.VERSION.SDK_INT >= 28) {
                runCatching { tm.simCarrierIdName?.toString()?.takeIf { it.isNotBlank() } }.getOrNull()
            } else null,
            "specificCarrierIdName" to if (Build.VERSION.SDK_INT >= 29) {
                runCatching { tm.simSpecificCarrierIdName?.toString()?.takeIf { it.isNotBlank() } }.getOrNull()
            } else null,
            "networkOperator" to runCatching { tm.networkOperator.takeIf { it.isNotBlank() } }.getOrNull(),
            "networkOperatorName" to runCatching { tm.networkOperatorName.takeIf { it.isNotBlank() } }.getOrNull(),
            "networkCountryIso" to runCatching { tm.networkCountryIso.takeIf { it.isNotBlank() } }.getOrNull(),
            "isRoaming" to runCatching { tm.isNetworkRoaming }.getOrNull(),
            "dataNetworkType" to runCatching { tm.dataNetworkType }.getOrNull(),
            "voiceNetworkType" to runCatching { tm.voiceNetworkType }.getOrNull(),
            "phoneType" to runCatching { tm.phoneType }.getOrNull(),
            "dataState" to runCatching { tm.dataState }.getOrNull(),
            "dataActivity" to runCatching { tm.dataActivity }.getOrNull(),
            "isDataEnabled" to if (Build.VERSION.SDK_INT >= 26) {
                runCatching { tm.isDataEnabled }.getOrNull()
            } else null,
        )
    }

    // --- signal ------------------------------------------------------------

    /// Snapshot of the current signal per active subscription, polled from
    /// Dart while the Network tab is visible. getSignalStrength (API 28+)
    /// needs no permission and no location, unlike getAllCellInfo.
    private fun signalSnapshot(): List<Map<String, Any?>> {
        if (Build.VERSION.SDK_INT < 28) return emptyList()
        if (!hasPermission(Manifest.permission.READ_PHONE_STATE)) return emptyList()
        val sm = getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
        val subs = runCatching { sm.activeSubscriptionInfoList }.getOrNull() ?: emptyList()
        val baseTm = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        return subs.map { si ->
            val tm = baseTm.createForSubscriptionId(si.subscriptionId)
            val strength = runCatching { tm.signalStrength }.getOrNull()
            val cells = if (Build.VERSION.SDK_INT >= 29 && strength != null) {
                strength.cellSignalStrengths.map { cell ->
                    mapOf(
                        "radio" to radioName(cell),
                        "dbm" to cell.dbm.takeIf { it != Int.MAX_VALUE && it != Int.MIN_VALUE },
                        "asu" to cell.asuLevel.takeIf { it != 99 && it != Int.MAX_VALUE },
                        "level" to cell.level,
                    )
                }
            } else {
                emptyList()
            }
            mapOf(
                "subscriptionId" to si.subscriptionId,
                "slotIndex" to si.simSlotIndex,
                "level" to strength?.level,
                "cells" to cells,
                "networkType" to runCatching { tm.dataNetworkType }.getOrNull(),
            )
        }
    }

    private fun radioName(cell: CellSignalStrength): String = when (cell) {
        is CellSignalStrengthNr -> "5G NR"
        is CellSignalStrengthLte -> "LTE"
        is CellSignalStrengthWcdma -> "WCDMA"
        is CellSignalStrengthTdscdma -> "TD-SCDMA"
        is CellSignalStrengthGsm -> "GSM"
        is CellSignalStrengthCdma -> "CDMA"
        else -> cell.javaClass.simpleName.removePrefix("CellSignalStrength")
    }

    // --- cell towers ---------------------------------------------------------

    /// Serving and neighbour cell identities. The one dataset in this app that
    /// needs ACCESS_FINE_LOCATION — Android treats a cell id as a location —
    /// which is why the UI asks for it only when the user opts in.
    private fun cellTowers(result: MethodChannel.Result) {
        if (!hasPermission(Manifest.permission.ACCESS_FINE_LOCATION) ||
            !hasPermission(Manifest.permission.READ_PHONE_STATE)
        ) {
            result.success(emptyList<Any>())
            return
        }
        val tm = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        fun cached(): List<Map<String, Any?>> =
            (runCatching { tm.allCellInfo }.getOrNull() ?: emptyList())
                .mapNotNull { cellMap(it) }

        if (Build.VERSION.SDK_INT >= 29) {
            // Ask the modem for a fresh scan; allCellInfo alone can be stale
            // by minutes. Fall back to the cache on any error or old device.
            try {
                tm.requestCellInfoUpdate(
                    mainExecutor,
                    object : TelephonyManager.CellInfoCallback() {
                        private var answered = false
                        override fun onCellInfo(cellInfo: MutableList<CellInfo>) {
                            if (answered) return
                            answered = true
                            result.success(cellInfo.mapNotNull { cellMap(it) })
                        }

                        override fun onError(errorCode: Int, detail: Throwable?) {
                            if (answered) return
                            answered = true
                            result.success(cached())
                        }
                    },
                )
            } catch (error: Exception) {
                result.success(cached())
            }
        } else {
            result.success(cached())
        }
    }

    /// One uniform shape per radio so the Dart side renders a single model:
    /// nulls for whatever a given technology or API level does not report.
    private fun cellMap(info: CellInfo): Map<String, Any?>? {
        fun v(value: Int?): Int? = value?.takeIf { it != Int.MAX_VALUE && it != Int.MIN_VALUE }
        fun v(value: Long?): Long? = value?.takeIf { it != Long.MAX_VALUE }

        val base = mutableMapOf<String, Any?>("registered" to info.isRegistered)
        when {
            Build.VERSION.SDK_INT >= 29 && info is CellInfoNr -> {
                val id = info.cellIdentity as? CellIdentityNr ?: return null
                val ss = info.cellSignalStrength as? CellSignalStrengthNr ?: return null
                base += mapOf(
                    "radio" to "5G NR",
                    "plmn" to plmn(id.mccString, id.mncString),
                    "cellId" to v(id.nci),
                    "area" to v(id.tac),
                    "pci" to v(id.pci),
                    "channel" to v(id.nrarfcn),
                    "bands" to if (Build.VERSION.SDK_INT >= 30) id.bands.toList() else null,
                    "dbm" to v(ss.dbm),
                    "level" to ss.level,
                    "rsrp" to v(ss.ssRsrp),
                    "rsrq" to v(ss.ssRsrq),
                    "sinr" to v(ss.ssSinr),
                )
            }
            info is CellInfoLte -> {
                val id = info.cellIdentity
                val ss = info.cellSignalStrength
                base += mapOf(
                    "radio" to "LTE",
                    "plmn" to if (Build.VERSION.SDK_INT >= 28) {
                        plmn(id.mccString, id.mncString)
                    } else {
                        @Suppress("DEPRECATION")
                        plmn(id.mcc.takeIf { it > 0 }?.toString(), id.mnc.takeIf { it >= 0 }?.toString())
                    },
                    "cellId" to v(id.ci)?.toLong(),
                    "area" to v(id.tac),
                    "pci" to v(id.pci),
                    "channel" to v(id.earfcn),
                    "bands" to if (Build.VERSION.SDK_INT >= 30) id.bands.toList() else null,
                    "bandwidthKhz" to if (Build.VERSION.SDK_INT >= 28) v(id.bandwidth) else null,
                    "dbm" to v(ss.dbm),
                    "level" to ss.level,
                    "rsrp" to if (Build.VERSION.SDK_INT >= 26) v(ss.rsrp) else null,
                    "rsrq" to if (Build.VERSION.SDK_INT >= 26) v(ss.rsrq) else null,
                    "sinr" to if (Build.VERSION.SDK_INT >= 26) v(ss.rssnr) else null,
                    "timingAdvance" to v(ss.timingAdvance),
                )
            }
            info is CellInfoWcdma -> {
                val id = info.cellIdentity
                val ss = info.cellSignalStrength
                base += mapOf(
                    "radio" to "WCDMA",
                    "plmn" to if (Build.VERSION.SDK_INT >= 28) {
                        plmn(id.mccString, id.mncString)
                    } else {
                        @Suppress("DEPRECATION")
                        plmn(id.mcc.takeIf { it > 0 }?.toString(), id.mnc.takeIf { it >= 0 }?.toString())
                    },
                    "cellId" to v(id.cid)?.toLong(),
                    "area" to v(id.lac),
                    "pci" to v(id.psc),
                    "channel" to v(id.uarfcn),
                    "dbm" to v(ss.dbm),
                    "level" to ss.level,
                )
            }
            Build.VERSION.SDK_INT >= 29 && info is CellInfoTdscdma -> {
                val id = info.cellIdentity
                val ss = info.cellSignalStrength
                base += mapOf(
                    "radio" to "TD-SCDMA",
                    "plmn" to plmn(id.mccString, id.mncString),
                    "cellId" to v(id.cid)?.toLong(),
                    "area" to v(id.lac),
                    "pci" to v(id.cpid),
                    "channel" to v(id.uarfcn),
                    "dbm" to v(ss.dbm),
                    "level" to ss.level,
                )
            }
            info is CellInfoGsm -> {
                val id = info.cellIdentity
                val ss = info.cellSignalStrength
                base += mapOf(
                    "radio" to "GSM",
                    "plmn" to if (Build.VERSION.SDK_INT >= 28) {
                        plmn(id.mccString, id.mncString)
                    } else {
                        @Suppress("DEPRECATION")
                        plmn(id.mcc.takeIf { it > 0 }?.toString(), id.mnc.takeIf { it >= 0 }?.toString())
                    },
                    "cellId" to v(id.cid)?.toLong(),
                    "area" to v(id.lac),
                    "channel" to v(id.arfcn),
                    "bsic" to v(id.bsic),
                    "dbm" to v(ss.dbm),
                    "level" to ss.level,
                    "timingAdvance" to if (Build.VERSION.SDK_INT >= 26) v(ss.timingAdvance) else null,
                )
            }
            info is CellInfoCdma -> {
                val ss = info.cellSignalStrength
                base += mapOf(
                    "radio" to "CDMA",
                    "dbm" to v(ss.dbm),
                    "level" to ss.level,
                )
            }
            else -> return null
        }
        return base
    }

    private fun plmn(mcc: String?, mnc: String?): String? =
        if (mcc != null && mnc != null) "$mcc-$mnc" else null

    // --- data usage ----------------------------------------------------------

    /// Special-access permission, granted from the Usage Access settings
    /// screen rather than a dialog. Checked through AppOps because
    /// checkSelfPermission always says denied for PACKAGE_USAGE_STATS.
    private fun hasUsageAccess(): Boolean {
        val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = if (Build.VERSION.SDK_INT >= 29) {
            appOps.unsafeCheckOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), packageName,
            )
        } else {
            @Suppress("DEPRECATION")
            appOps.checkOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), packageName,
            )
        }
        return mode == AppOpsManager.MODE_ALLOWED
    }

    /// Device totals, today and this calendar month. Cellular is all SIMs
    /// combined: a per-subscription split needs the subscriber id, which has
    /// been carrier-privileged since Android 10 — no public app can do it.
    private fun dataUsage(): Map<String, Any?> {
        if (!hasUsageAccess()) return mapOf("granted" to false)
        val nsm = getSystemService(Context.NETWORK_STATS_SERVICE) as NetworkStatsManager
        val now = System.currentTimeMillis()
        val calendar = Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }
        val dayStart = calendar.timeInMillis
        calendar.set(Calendar.DAY_OF_MONTH, 1)
        val monthStart = calendar.timeInMillis

        @Suppress("DEPRECATION")
        fun total(networkType: Int, start: Long): Long? = runCatching {
            val bucket = nsm.querySummaryForDevice(networkType, null, start, now)
            bucket.rxBytes + bucket.txBytes
        }.getOrNull()

        @Suppress("DEPRECATION")
        return mapOf(
            "granted" to true,
            "mobileToday" to total(ConnectivityManager.TYPE_MOBILE, dayStart),
            "mobileMonth" to total(ConnectivityManager.TYPE_MOBILE, monthStart),
            "wifiToday" to total(ConnectivityManager.TYPE_WIFI, dayStart),
            "wifiMonth" to total(ConnectivityManager.TYPE_WIFI, monthStart),
        )
    }

    // --- system screens ------------------------------------------------------

    private fun openSystemScreen(screen: String) {
        val action = when (screen) {
            "mobile" -> Settings.ACTION_DATA_ROAMING_SETTINGS
            "dataUsage" -> Settings.ACTION_DATA_USAGE_SETTINGS
            "wifi" -> Settings.ACTION_WIFI_SETTINGS
            "airplane" -> Settings.ACTION_AIRPLANE_MODE_SETTINGS
            else -> Settings.ACTION_WIRELESS_SETTINGS
        }
        try {
            startActivity(Intent(action))
        } catch (error: ActivityNotFoundException) {
            // Not every OEM ships every settings screen; land somewhere sane.
            startActivity(Intent(Settings.ACTION_WIRELESS_SETTINGS))
        }
    }

    // --- device ------------------------------------------------------------

    private fun deviceInfo(): Map<String, Any?> {
        val tm = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        val hasPhoneState = hasPermission(Manifest.permission.READ_PHONE_STATE)
        val esimSupported: Boolean? = if (Build.VERSION.SDK_INT >= 28) {
            runCatching {
                (getSystemService(Context.EUICC_SERVICE) as? EuiccManager)?.isEnabled
            }.getOrNull()
        } else null
        return mapOf(
            "manufacturer" to Build.MANUFACTURER,
            "model" to Build.MODEL,
            "device" to Build.DEVICE,
            "androidVersion" to Build.VERSION.RELEASE,
            "sdkInt" to Build.VERSION.SDK_INT,
            "hasTelephony" to packageManager.hasSystemFeature(PackageManager.FEATURE_TELEPHONY),
            "esimSupported" to esimSupported,
            "activeModemCount" to when {
                Build.VERSION.SDK_INT >= 30 -> runCatching { tm.activeModemCount }.getOrNull()
                else -> @Suppress("DEPRECATION") runCatching { tm.phoneCount }.getOrNull()
            },
            "supportedModemCount" to if (Build.VERSION.SDK_INT >= 30) {
                runCatching { tm.supportedModemCount }.getOrNull()
            } else null,
            "isVoiceCapable" to runCatching { tm.isVoiceCapable }.getOrNull(),
            "isSmsCapable" to runCatching { tm.isSmsCapable }.getOrNull(),
            "hasIccCard" to runCatching { tm.hasIccCard() }.getOrNull(),
            "isConcurrentVoiceAndData" to if (Build.VERSION.SDK_INT >= 26 && hasPhoneState) {
                runCatching { tm.isConcurrentVoiceAndDataSupported }.getOrNull()
            } else null,
            "deviceSoftwareVersion" to if (hasPhoneState) {
                runCatching { tm.deviceSoftwareVersion }.getOrNull()
            } else null,
            "maxActiveSubscriptions" to run {
                val sm = getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
                runCatching { sm.activeSubscriptionInfoCountMax }.getOrNull()
            },
        )
    }

    // --- connectivity -------------------------------------------------------

    private fun connectivityInfo(): Map<String, Any?> {
        val cm = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = cm.activeNetwork ?: return mapOf("connected" to false)
        val caps: NetworkCapabilities? = runCatching { cm.getNetworkCapabilities(network) }.getOrNull()
        val link: LinkProperties? = runCatching { cm.getLinkProperties(network) }.getOrNull()

        val transports = mutableListOf<String>()
        if (caps != null) {
            if (caps.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) transports.add("Wi-Fi")
            if (caps.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) transports.add("Cellular")
            if (caps.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) transports.add("Ethernet")
            if (caps.hasTransport(NetworkCapabilities.TRANSPORT_BLUETOOTH)) transports.add("Bluetooth")
            if (caps.hasTransport(NetworkCapabilities.TRANSPORT_VPN)) transports.add("VPN")
        }

        return mapOf(
            "connected" to true,
            "transports" to transports,
            "validated" to caps?.hasCapability(NetworkCapabilities.NET_CAPABILITY_VALIDATED),
            "metered" to caps?.let { !it.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_METERED) },
            "downstreamKbps" to caps?.linkDownstreamBandwidthKbps?.takeIf { it > 0 },
            "upstreamKbps" to caps?.linkUpstreamBandwidthKbps?.takeIf { it > 0 },
            "interfaceName" to link?.interfaceName,
            "dnsServers" to (link?.dnsServers?.mapNotNull { it.hostAddress } ?: emptyList<String>()),
            "privateDnsActive" to if (Build.VERSION.SDK_INT >= 28) link?.isPrivateDnsActive else null,
            "privateDnsServer" to if (Build.VERSION.SDK_INT >= 28) link?.privateDnsServerName else null,
            "addresses" to (link?.linkAddresses?.map { it.toString() } ?: emptyList<String>()),
            "domains" to link?.domains,
        )
    }
}
