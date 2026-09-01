import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sim_card_info/l10n/generated/app_localizations.dart';

/// Every supported locale must actually resolve — gen-l10n will happily ship
/// an English UI to a user whose language is missing from supportedLocales,
/// which a sibling app only caught on a device.
void main() {
  test('fifteen locales are supported', () {
    final codes =
        AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet();
    expect(codes, {
      'ar', 'bn', 'de', 'en', 'es', 'fr', 'hi', 'it',
      'ja', 'ko', 'pt', 'ru', 'tr', 'ur', 'zh',
    });
  });

  testWidgets('every locale loads and localizes the chrome', (tester) async {
    for (final locale in AppLocalizations.supportedLocales) {
      late AppLocalizations l10n;
      await tester.pumpWidget(
        MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(l10n.appTitle, isNotEmpty, reason: 'appTitle empty in $locale');
      expect(l10n.gateBody, isNotEmpty, reason: 'gateBody empty in $locale');
      // Placeholders survive translation.
      expect(l10n.copied('X'), contains('X'),
          reason: 'copied() lost its placeholder in $locale');
      expect(l10n.simN(2), contains('2'),
          reason: 'simN() lost its placeholder in $locale');
      expect(l10n.sparklineCaption(-85, 'w'), contains('-85'),
          reason: 'sparklineCaption() lost its dbm placeholder in $locale');
    }
  });
}
