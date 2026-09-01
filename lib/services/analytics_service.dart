import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Feature analytics, attached once Firebase is up and a silent no-op until
/// then (and forever, in tests and when Firebase fails to start).
///
/// Only feature usage is logged — which screens get opened, which optional
/// sections get enabled — never any value the app displays: carrier names,
/// numbers, cell ids and usage figures are the user's data, and a sibling
/// app has already shipped the mistake of logging user content.
abstract final class AnalyticsService {
  static FirebaseAnalytics? _analytics;

  static void attach(FirebaseAnalytics analytics) {
    _analytics = analytics;
  }

  static void _log(String name, [Map<String, Object>? parameters]) {
    final analytics = _analytics;
    if (analytics == null) return;
    analytics
        .logEvent(name: name, parameters: parameters)
        .catchError((Object error) => debugPrint('analytics: $error'));
  }

  static void logAppOpened({required String themeMode, required String locale}) =>
      _log('app_opened', {'theme_mode': themeMode, 'app_locale': locale});

  /// Which tab the user lands on; the label is the tab's stable slug, not the
  /// localized title.
  static void logTabSelected(String tab) => _log('tab_selected', {'tab': tab});

  static void logRefresh() => _log('overview_refreshed');

  static void logCellTowersEnabled() => _log('cell_towers_enabled');

  static void logUsageAccessOpened() => _log('usage_access_opened');

  static void logLatencyTest() => _log('latency_test_run');

  /// [format] is 'text' or 'json'.
  static void logReportShared(String format) =>
      _log('report_shared', {'format': format});

  static void logThemeChanged(String themeMode) =>
      _log('theme_changed', {'theme_mode': themeMode});

  static void logLanguageChanged(String locale) =>
      _log('language_changed', {'app_locale': locale});

  /// UMP outcome as a user property, so ad-revenue questions can be split by
  /// consent state.
  static void setConsentProperty(String value) {
    final analytics = _analytics;
    if (analytics == null) return;
    analytics
        .setUserProperty(name: 'ads_consent', value: value)
        .catchError((Object error) => debugPrint('analytics: $error'));
  }
}
