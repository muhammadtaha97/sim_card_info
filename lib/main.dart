import 'package:flutter/material.dart';

import 'app.dart';
import 'services/ad_service.dart';
import 'services/consent_service.dart';
import 'services/settings_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = await SettingsStore.load();

  // Consent first, then the ads SDK — deliberately not awaited: first paint
  // must not wait on a network round-trip to Google, and every ad load
  // already waits on AdsBootstrap.ready internally.
  ConsentService.gather().then(
    (canRequestAds) => AdsBootstrap.init(canRequestAds: canRequestAds),
  );

  runApp(SimCardInfoApp(settings: settings));
}
