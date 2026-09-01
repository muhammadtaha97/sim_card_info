package com.tahatec.sim_card_info

import android.Manifest
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager
import android.widget.RemoteViews
import androidx.core.content.ContextCompat
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/// Home screen widget: one line per active SIM with carrier, network type and
/// the signal bucket at the last refresh.
///
/// It reads telephony directly rather than being fed by the Flutter side, so
/// it works even when the app process is dead. Kept to plain TextViews on a
/// static background: RemoteViews silently drops anything fancier, a trap a
/// sibling app's widget already paid for. Launcher-driven refreshes come every
/// 30 minutes (updatePeriodMillis' floor); opening the app refreshes it too.
class SimInfoWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (id in appWidgetIds) {
            appWidgetManager.updateAppWidget(id, build(context))
        }
    }

    companion object {
        /// Called from the app (channel method refreshWidget) after every
        /// reload, so the widget is at most one app-open stale.
        fun refreshAll(context: Context) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(
                ComponentName(context, SimInfoWidget::class.java),
            )
            for (id in ids) {
                manager.updateAppWidget(id, build(context))
            }
        }

        private fun build(context: Context): RemoteViews {
            val views = RemoteViews(context.packageName, R.layout.widget_sim)

            val time = SimpleDateFormat("HH:mm", Locale.getDefault()).format(Date())
            views.setTextViewText(R.id.widget_title, "SIM Card Info · $time")

            val lines = simLines(context)
            views.setTextViewText(
                R.id.widget_line1,
                lines.getOrNull(0) ?: context.getString(R.string.widget_no_data),
            )
            if (lines.size > 1) {
                views.setTextViewText(R.id.widget_line2, lines[1])
                views.setViewVisibility(R.id.widget_line2, android.view.View.VISIBLE)
            } else {
                views.setViewVisibility(R.id.widget_line2, android.view.View.GONE)
            }

            val launch = PendingIntent.getActivity(
                context,
                0,
                Intent(context, MainActivity::class.java),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )
            views.setOnClickPendingIntent(R.id.widget_root, launch)
            return views
        }

        private fun simLines(context: Context): List<String> {
            val granted = ContextCompat.checkSelfPermission(
                context, Manifest.permission.READ_PHONE_STATE,
            ) == PackageManager.PERMISSION_GRANTED
            if (!granted) return emptyList()

            val sm = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE)
                as SubscriptionManager
            val subs = runCatching { sm.activeSubscriptionInfoList }.getOrNull()
                ?: return emptyList()
            val baseTm = context.getSystemService(Context.TELEPHONY_SERVICE)
                as TelephonyManager

            return subs.take(2).map { si ->
                val tm = baseTm.createForSubscriptionId(si.subscriptionId)
                val carrier = si.carrierName?.toString()
                    ?: si.displayName?.toString()
                    ?: "SIM ${si.simSlotIndex + 1}"
                val generation = when (runCatching { tm.dataNetworkType }.getOrNull()) {
                    1, 2, 7, 11, 16 -> "2G"
                    3, 4, 5, 6, 8, 9, 10, 12, 14, 15, 17 -> "3G"
                    13, 19 -> "4G"
                    20 -> "5G"
                    else -> null
                }
                val level = if (Build.VERSION.SDK_INT >= 28) {
                    runCatching { tm.signalStrength?.level }.getOrNull()
                } else null
                val bars = when (level) {
                    4 -> "▂▄▆█"
                    3 -> "▂▄▆"
                    2 -> "▂▄"
                    1 -> "▂"
                    0 -> "·"
                    else -> null
                }
                listOfNotNull(carrier, generation, bars).joinToString("  ·  ")
            }
        }
    }
}
