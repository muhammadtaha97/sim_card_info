import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'services/ad_service.dart';
import 'services/analytics_service.dart';
import 'services/consent_service.dart';
import 'services/crash_reporter.dart';
import 'services/settings_store.dart';

/// Startup. The order matters:
///
///  1. **Crash handlers first**, before Firebase, so a failure during the
///     rest of this function is still reported once Firebase comes up.
///  2. **Preferences**, because the first frame needs the stored theme and
///     language.
///  3. **Firebase**, awaited but wrapped: an app whose features are all
///     on-device must still start when Firebase does not.
///  4. **The consent flow, then the ads SDK — not awaited.** MobileAds
///     initialization has been measured at tens of seconds on a slow device;
///     ad loads wait on it internally instead of the first frame doing so.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CrashReporter.install();

  final settings = await SettingsStore.load();

  try {
    await Firebase.initializeApp();
    CrashReporter.markReady(available: true);
    AnalyticsService.attach(FirebaseAnalytics.instance);
    AnalyticsService.logAppOpened(
      themeMode: settings.themeMode.name,
      locale: settings.localeOverride?.languageCode ?? 'system',
    );
  } catch (error, stack) {
    debugPrint('Firebase did not start: $error');
    debugPrintStack(stackTrace: stack);
    // Releases anything CrashReporter was holding for a Firebase that will
    // never arrive, so the queue cannot grow for the life of the process.
    CrashReporter.markReady(available: false);
  }

  unawaited(
    ConsentService.gather().then((canRequestAds) {
      AnalyticsService.setConsentProperty(
        canRequestAds ? 'granted' : 'withheld',
      );
      return AdsBootstrap.init(canRequestAds: canRequestAds);
    }),
  );

  runApp(SimCardInfoApp(settings: settings));
}
