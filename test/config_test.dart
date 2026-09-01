import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sim_card_info/l10n/generated/app_localizations.dart';
import 'package:sim_card_info/services/ad_service.dart';
import 'package:sim_card_info/utils/language_names.dart';

/// Checks the Dart constants against the Android config they have to agree
/// with. Nothing here tests behaviour — it tests that two files that must say
/// the same thing do, which is the class of mistake that is invisible at
/// runtime and only shows up as revenue landing under the wrong app.
void main() {
  late final String manifest;
  late final String appGradle;

  setUpAll(() {
    manifest =
        File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    appGradle = File('android/app/build.gradle.kts').readAsStringSync();
  });

  group('AdMob', () {
    test('the manifest app id matches the Dart constant', () {
      final match = RegExp(
        r'com\.google\.android\.gms\.ads\.APPLICATION_ID"\s*\n?\s*android:value="([^"]+)"',
      ).firstMatch(manifest);
      expect(match, isNotNull,
          reason: 'no AdMob APPLICATION_ID in the manifest');
      expect(match!.group(1), AdUnits.applicationId);
    });

    test("the ids are the ones this app was given, not a sibling app's", () {
      // These apps share one AdMob publisher account, so a copied id is a
      // silent revenue leak into another app. Pinned literally on purpose:
      // this test should fail if anyone edits ad_service.dart by hand.
      expect(AdUnits.applicationId, 'ca-app-pub-9785628886941445~2184752117');
      expect(AdUnits.bannerLive, 'ca-app-pub-9785628886941445/3230345678');
      expect(
          AdUnits.interstitialLive, 'ca-app-pub-9785628886941445/1689928098');
    });

    test('no test unit ships in a release build', () {
      expect(AdUnits.useTestUnits, isFalse,
          reason: 'flip AdUnits.useTestUnits back to false before shipping');
      expect(AdUnits.anyTestUnit, isFalse);
    });

    test('every unit belongs to this publisher and is well formed', () {
      for (final unit in AdUnits.allOwnUnits) {
        expect(unit, startsWith('${AdUnits.publisherPrefix}/'));
        expect(RegExp(r'^ca-app-pub-\d{16}/\d{10}$').hasMatch(unit), isTrue,
            reason: '$unit is not a valid ad unit id');
      }
      expect(
          RegExp(r'^ca-app-pub-\d{16}~\d{10}$')
              .hasMatch(AdUnits.applicationId),
          isTrue);
    });

    test('banner and interstitial are different units', () {
      expect(AdUnits.bannerLive, isNot(AdUnits.interstitialLive));
    });

    test('no unit id is the application id in unit position', () {
      // A sibling app shipped its banner slot carrying the AdMob *app* id
      // (the ~ form) and earned nothing from that slot for its entire life.
      for (final unit in AdUnits.allOwnUnits) {
        expect(unit.contains('~'), isFalse,
            reason: '$unit looks like an application id, not a unit id');
      }
    });
  });

  group('Android build config', () {
    test('the application id is the intended package name', () {
      expect(appGradle,
          contains('applicationId = "com.tahatec.sim_card_info"'));
      expect(appGradle, contains('namespace = "com.tahatec.sim_card_info"'));
    });

    test('targets API 37 as decided for this app', () {
      expect(appGradle, contains('compileSdk = 37'));
      expect(appGradle, contains('targetSdk = 37'));
    });

    test('R8 is stated explicitly and has rules behind it', () {
      expect(appGradle, contains('isMinifyEnabled = true'));
      expect(appGradle, contains('proguard-rules.pro'));
      final rules = File('android/app/proguard-rules.pro');
      expect(rules.existsSync(), isTrue,
          reason: 'proguardFiles names a file that does not exist');
      final text = rules.readAsStringSync();
      expect(text, contains('**_Impl'),
          reason: 'missing the Room keep rule (androidx.work via the ads SDK)');
      expect(text, contains('com.google.ads.mediation'),
          reason: 'missing the mediation adapter keep rule');
      expect(text, contains('com.google.android.ump'),
          reason: 'missing the UMP keep rule');
    });

    test('the signing config uses the release keystore, not debug', () {
      expect(appGradle, contains('signingConfigs.getByName("release")'));
    });

    test('the manifest declares the permissions the channel needs', () {
      expect(manifest, contains('android.permission.READ_PHONE_STATE'));
      expect(manifest, contains('android.permission.READ_PHONE_NUMBERS'));
      expect(manifest, contains('android.permission.ACCESS_NETWORK_STATE'));
      expect(manifest, contains('android.permission.INTERNET'));
    });

    test('telephony hardware is optional so tablets can install', () {
      expect(
        RegExp(r'android\.hardware\.telephony"\s*\n?\s*android:required="false"')
            .hasMatch(manifest),
        isTrue,
      );
    });

    test('opt-in permissions are declared for the gated sections', () {
      // Cell towers need fine location; data usage needs the Usage Access
      // special permission. Both are requested only on user opt-in, but they
      // must be in the manifest or the runtime request silently no-ops.
      expect(manifest, contains('android.permission.ACCESS_FINE_LOCATION'));
      expect(manifest, contains('android.permission.PACKAGE_USAGE_STATS'));
    });

    test('the widget receiver is registered and its pieces exist', () {
      expect(manifest, contains('android:name=".SimInfoWidget"'));
      expect(manifest, contains('android.appwidget.action.APPWIDGET_UPDATE'));
      expect(manifest, contains('@xml/widget_sim_info'));
      expect(
        File('android/app/src/main/kotlin/com/tahatec/sim_card_info/SimInfoWidget.kt')
            .existsSync(),
        isTrue,
      );
      expect(
        File('android/app/src/main/res/xml/widget_sim_info.xml').existsSync(),
        isTrue,
      );
      final provider =
          File('android/app/src/main/res/xml/widget_sim_info.xml')
              .readAsStringSync();
      final layout = RegExp(r'android:initialLayout="@layout/([^"]+)"')
          .firstMatch(provider);
      expect(layout, isNotNull);
      expect(
        File('android/app/src/main/res/layout/${layout!.group(1)}.xml')
            .existsSync(),
        isTrue,
        reason: 'the widget provider names a layout that does not exist',
      );
    });

    test('locales_config matches supportedLocales exactly', () {
      // The manifest declaration is what makes the Android 13+ per-app
      // language setting appear; a locale missing from either side is a
      // language that silently cannot be chosen there.
      expect(manifest, contains('android:localeConfig="@xml/locales_config"'));
      final xml = File('android/app/src/main/res/xml/locales_config.xml')
          .readAsStringSync();
      final declared = RegExp(r'android:name="([a-z]{2})"')
          .allMatches(xml)
          .map((match) => match.group(1))
          .toSet();
      final supported = AppLocalizations.supportedLocales
          .map((locale) => locale.languageCode)
          .toSet();
      expect(declared, supported);
      // And the picker can name every one of them.
      expect(nativeLanguageNames.keys.toSet(), supported);
    });

    test('the Kotlin channel name matches the Dart one', () {
      final kotlin = File(
        'android/app/src/main/kotlin/com/tahatec/sim_card_info/MainActivity.kt',
      ).readAsStringSync();
      final dart =
          File('lib/services/telephony_service.dart').readAsStringSync();
      const channel = 'com.tahatec.sim_card_info/telephony';
      expect(kotlin, contains('"$channel"'));
      expect(dart, contains("'$channel'"));

      // Every method Dart invokes must have a Kotlin handler; a typo here is
      // a MissingPluginException that the degraded-to-null design would hide.
      for (final method in [
        'checkPermissions',
        'requestPermissions',
        'requestLocationPermission',
        'openAppSettings',
        'openSystemScreen',
        'openUsageAccessSettings',
        'getOverview',
        'getSignal',
        'getCellTowers',
        'getDataUsage',
        'refreshWidget',
        'setAppLocales',
      ]) {
        expect(kotlin, contains('"$method"'),
            reason: 'MainActivity.kt has no handler for $method');
      }
    });
  });
}
