import 'package:flutter/material.dart';

import 'l10n/generated/app_localizations.dart';
import 'screens/home_screen.dart';
import 'services/settings_store.dart';
import 'services/telephony_service.dart';
import 'theme/app_theme.dart';

class SimCardInfoApp extends StatelessWidget {
  const SimCardInfoApp({super.key, required this.settings, this.telephony});

  final SettingsStore settings;

  /// Injectable for widget tests, like on HomeScreen.
  final TelephonyService? telephony;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) => MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: settings.themeMode,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // Null follows the system (including the Android 13+ per-app
        // language setting); a value is the in-app picker's override.
        locale: settings.localeOverride,
        home: HomeScreen(settings: settings, telephony: telephony),
      ),
    );
  }
}
