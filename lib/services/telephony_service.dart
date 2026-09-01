import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/cell_tower.dart';
import '../models/data_usage.dart';
import '../models/signal_info.dart';
import '../models/telephony_overview.dart';

/// Dart side of the app's own telephony bridge (see MainActivity.kt).
///
/// Every call degrades instead of throwing: a missing channel (tests, iOS,
/// a broken engine) returns the same empty shapes a permission denial does,
/// so the UI has exactly one degraded state to render.
class TelephonyService {
  static const _channel = MethodChannel('com.tahatec.sim_card_info/telephony');

  /// True only where MainActivity.kt actually exists.
  static bool get supported => !kIsWeb && Platform.isAndroid;

  Future<PermissionStates> checkPermissions() async {
    if (!supported) return PermissionStates.denied;
    try {
      final map =
          await _channel.invokeMethod<Map<Object?, Object?>>('checkPermissions');
      return map == null
          ? PermissionStates.denied
          : PermissionStates.fromMap(map);
    } on PlatformException catch (error) {
      debugPrint('checkPermissions failed: $error');
      return PermissionStates.denied;
    } on MissingPluginException {
      return PermissionStates.denied;
    }
  }

  /// Shows the system dialog and resolves with the states after the user
  /// answers it.
  Future<PermissionStates> requestPermissions() async {
    if (!supported) return PermissionStates.denied;
    try {
      final map = await _channel
          .invokeMethod<Map<Object?, Object?>>('requestPermissions');
      return map == null
          ? PermissionStates.denied
          : PermissionStates.fromMap(map);
    } on PlatformException catch (error) {
      debugPrint('requestPermissions failed: $error');
      return PermissionStates.denied;
    } on MissingPluginException {
      return PermissionStates.denied;
    }
  }

  /// The only way forward after a permanent denial.
  Future<void> openAppSettings() async {
    if (!supported) return;
    try {
      await _channel.invokeMethod<void>('openAppSettings');
    } on PlatformException catch (error) {
      debugPrint('openAppSettings failed: $error');
    } on MissingPluginException {
      // Nothing to open outside Android.
    }
  }

  Future<TelephonyOverview?> getOverview() async {
    if (!supported) return null;
    try {
      final map =
          await _channel.invokeMethod<Map<Object?, Object?>>('getOverview');
      return map == null ? null : TelephonyOverview.fromMap(map);
    } on PlatformException catch (error) {
      debugPrint('getOverview failed: $error');
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  /// One signal snapshot per active subscription; polled while the Network
  /// tab is on screen.
  Future<List<SignalInfo>> getSignal() async {
    if (!supported) return const [];
    try {
      final list = await _channel.invokeMethod<List<Object?>>('getSignal');
      return (list ?? const [])
          .whereType<Map<Object?, Object?>>()
          .map(SignalInfo.fromMap)
          .toList();
    } on PlatformException catch (error) {
      debugPrint('getSignal failed: $error');
      return const [];
    } on MissingPluginException {
      return const [];
    }
  }

  /// Opt-in: fine location, requested only when the user enables the cell
  /// towers section.
  Future<PermissionStates> requestLocationPermission() async {
    if (!supported) return PermissionStates.denied;
    try {
      final map = await _channel
          .invokeMethod<Map<Object?, Object?>>('requestLocationPermission');
      return map == null
          ? PermissionStates.denied
          : PermissionStates.fromMap(map);
    } on PlatformException catch (error) {
      debugPrint('requestLocationPermission failed: $error');
      return PermissionStates.denied;
    } on MissingPluginException {
      return PermissionStates.denied;
    }
  }

  /// Serving and neighbour cells; empty until location is granted.
  Future<List<CellTower>> getCellTowers() async {
    if (!supported) return const [];
    try {
      final list = await _channel.invokeMethod<List<Object?>>('getCellTowers');
      return (list ?? const [])
          .whereType<Map<Object?, Object?>>()
          .map(CellTower.fromMap)
          .toList();
    } on PlatformException catch (error) {
      debugPrint('getCellTowers failed: $error');
      return const [];
    } on MissingPluginException {
      return const [];
    }
  }

  /// Device data-usage totals; `granted: false` until Usage Access is on.
  Future<DataUsage> getDataUsage() async {
    if (!supported) return DataUsage.denied;
    try {
      final map =
          await _channel.invokeMethod<Map<Object?, Object?>>('getDataUsage');
      return map == null ? DataUsage.denied : DataUsage.fromMap(map);
    } on PlatformException catch (error) {
      debugPrint('getDataUsage failed: $error');
      return DataUsage.denied;
    } on MissingPluginException {
      return DataUsage.denied;
    }
  }

  /// Opens the system Usage Access screen where the special grant lives.
  Future<void> openUsageAccessSettings() async {
    if (!supported) return;
    try {
      await _channel.invokeMethod<void>('openUsageAccessSettings');
    } on PlatformException catch (error) {
      debugPrint('openUsageAccessSettings failed: $error');
    } on MissingPluginException {
      // Nothing to open outside Android.
    }
  }

  /// Jump to a system settings screen: mobile / dataUsage / wifi / airplane.
  Future<void> openSystemScreen(String screen) async {
    if (!supported) return;
    try {
      await _channel
          .invokeMethod<void>('openSystemScreen', {'screen': screen});
    } on PlatformException catch (error) {
      debugPrint('openSystemScreen failed: $error');
    } on MissingPluginException {
      // Nothing to open outside Android.
    }
  }

  /// Mirrors the in-app language choice into the Android 13+ per-app
  /// language setting, so system Settings shows the same answer. Pass null
  /// to clear back to "system default". No-op below API 33.
  Future<void> setAppLocales(String? languageTag) async {
    if (!supported) return;
    try {
      await _channel
          .invokeMethod<void>('setAppLocales', {'tag': languageTag ?? ''});
    } on PlatformException catch (error) {
      debugPrint('setAppLocales failed: $error');
    } on MissingPluginException {
      // No system setting to mirror outside Android.
    }
  }

  /// Pushes fresh data into any home screen widgets.
  Future<void> refreshWidget() async {
    if (!supported) return;
    try {
      await _channel.invokeMethod<void>('refreshWidget');
    } on PlatformException catch (error) {
      debugPrint('refreshWidget failed: $error');
    } on MissingPluginException {
      // No widgets outside Android.
    }
  }

  /// Local interface addresses, read in pure Dart so no platform code is
  /// needed. Loopback is skipped: the user is asking "what is my IP", not
  /// "does localhost exist".
  Future<List<({String interface, String address, bool isIPv6})>>
      localAddresses() async {
    if (kIsWeb) return const [];
    try {
      final interfaces = await NetworkInterface.list(includeLinkLocal: false);
      return [
        for (final ni in interfaces)
          for (final addr in ni.addresses)
            if (!addr.isLoopback)
              (
                interface: ni.name,
                address: addr.address,
                isIPv6: addr.type == InternetAddressType.IPv6,
              ),
      ];
    } catch (error) {
      debugPrint('localAddresses failed: $error');
      return const [];
    }
  }
}
