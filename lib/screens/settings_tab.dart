import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/generated/app_localizations.dart';
import '../services/analytics_service.dart';
import '../services/consent_service.dart';
import '../services/settings_store.dart';
import '../utils/language_names.dart';

/// Theme, language, privacy, share and about.
class SettingsTab extends StatelessWidget {
  const SettingsTab({
    super.key,
    required this.settings,
    required this.onShareReport,
    this.onShareJsonReport,
    this.onLocaleChanged,
  });

  final SettingsStore settings;
  final VoidCallback onShareReport;
  final VoidCallback? onShareJsonReport;

  /// Mirrors the choice into the Android 13+ per-app language setting.
  final ValueChanged<String?>? onLocaleChanged;

  Future<void> _pickLanguage(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final current = settings.localeOverride?.languageCode;
    // Sentinel for "system default": showDialog can't tell a null result
    // (dismissed) from a null choice, so the choice carries its own marker.
    const system = '';
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.labelLanguage),
        children: [
          RadioGroup<String>(
            groupValue: current ?? system,
            onChanged: (value) => Navigator.pop(context, value),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  value: system,
                  title: Text(l10n.systemDefault),
                ),
                for (final locale in AppLocalizations.supportedLocales)
                  RadioListTile<String>(
                    value: locale.languageCode,
                    title: Text(nativeLanguageNames[locale.languageCode] ??
                        locale.languageCode),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    if (choice == null) return;
    final code = choice == system ? null : choice;
    AnalyticsService.logLanguageChanged(code ?? 'system');
    await settings.setLocaleOverride(code == null ? null : Locale(code));
    onLocaleChanged?.call(code);
  }

  static const _playUrl =
      'https://play.google.com/store/apps/details?id=com.tahatec.sim_card_info';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                child: Row(
                  children: [
                    Icon(Icons.palette_outlined,
                        size: 18, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      l10n.sectionAppearance,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
              ListenableBuilder(
                listenable: settings,
                builder: (context, _) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                      child: SegmentedButton<ThemeMode>(
                        segments: [
                          ButtonSegment(
                            value: ThemeMode.light,
                            label: Text(l10n.themeLight),
                            icon: const Icon(Icons.light_mode_outlined),
                          ),
                          ButtonSegment(
                            value: ThemeMode.system,
                            label: Text(l10n.themeSystem),
                            icon: const Icon(Icons.brightness_auto_outlined),
                          ),
                          ButtonSegment(
                            value: ThemeMode.dark,
                            label: Text(l10n.themeDark),
                            icon: const Icon(Icons.dark_mode_outlined),
                          ),
                        ],
                        selected: {settings.themeMode},
                        onSelectionChanged: (selection) {
                          AnalyticsService.logThemeChanged(
                            selection.first.name,
                          );
                          settings.setThemeMode(selection.first);
                        },
                      ),
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(l10n.labelLanguage),
                      subtitle: Text(
                        settings.localeOverride == null
                            ? l10n.systemDefault
                            : nativeLanguageNames[
                                    settings.localeOverride!.languageCode] ??
                                settings.localeOverride!.languageCode,
                      ),
                      onTap: () => _pickLanguage(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.ios_share),
                title: Text(l10n.shareFullReport),
                subtitle: Text(l10n.shareFullReportSubtitle),
                onTap: onShareReport,
              ),
              const Divider(indent: 16, endIndent: 16),
              ListTile(
                leading: const Icon(Icons.data_object),
                title: Text(l10n.shareJson),
                subtitle: Text(l10n.shareJsonSubtitle),
                onTap: onShareJsonReport,
              ),
              const Divider(indent: 16, endIndent: 16),
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: Text(l10n.shareApp),
                onTap: () => SharePlus.instance.share(
                  ShareParams(text: l10n.shareAppText(_playUrl)),
                ),
              ),
              // Required in the EEA/UK once consent is gathered; hidden
              // elsewhere, where the form does not exist.
              ValueListenableBuilder<bool>(
                valueListenable: ConsentService.privacyOptionsRequired,
                builder: (context, required, _) {
                  if (!required) return const SizedBox.shrink();
                  return Column(
                    children: [
                      const Divider(indent: 16, endIndent: 16),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip_outlined),
                        title: Text(l10n.privacyOptions),
                        subtitle: Text(l10n.privacyOptionsSubtitle),
                        onTap: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final error =
                              await ConsentService.showPrivacyOptions();
                          if (error != null) {
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  l10n.privacyOptionsFailed(
                                    error.message,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              final info = snapshot.data;
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('SIM Card Info'),
                    subtitle: Text(
                      info == null
                          ? l10n.aboutBy
                          : l10n.aboutVersion(
                              '${info.version} (${info.buildNumber})',
                            ),
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Text(
                      l10n.privacyNote,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
