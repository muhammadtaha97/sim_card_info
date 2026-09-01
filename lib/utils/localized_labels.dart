/// Localized variants of the value words in labels.dart.
///
/// labels.dart stays English on purpose — the shareable report is a technical
/// document that support threads read in English — while everything painted
/// on screen goes through these. Radio names (LTE, GSM, 5G NR…) are terms of
/// art and stay as they are in every language.
library;

import '../l10n/generated/app_localizations.dart';

String localizedYesNo(AppLocalizations l10n, bool? value) => switch (value) {
      true => l10n.yes,
      false => l10n.no,
      null => l10n.unavailable,
    };

String localizedSimState(AppLocalizations l10n, int? state) => switch (state) {
      0 => l10n.unknown,
      1 => l10n.simStateAbsent,
      2 => l10n.simStatePin,
      3 => l10n.simStatePuk,
      4 => l10n.simStateNetworkLocked,
      5 => l10n.simStateReady,
      6 => l10n.simStateNotReady,
      7 => l10n.simStateDisabled,
      8 => l10n.simStateIoError,
      9 => l10n.simStateRestricted,
      null => l10n.unavailable,
      _ => 'State $state',
    };

String localizedDataState(AppLocalizations l10n, int? state) =>
    switch (state) {
      0 => l10n.dataDisconnected,
      1 => l10n.dataConnecting,
      2 => l10n.dataConnected,
      3 => l10n.dataSuspended,
      4 => l10n.dataDisconnecting,
      null => l10n.unavailable,
      _ => 'State $state',
    };

String localizedDataActivity(AppLocalizations l10n, int? activity) =>
    switch (activity) {
      0 => l10n.activityIdle,
      1 => l10n.activityReceiving,
      2 => l10n.activitySending,
      3 => l10n.activityBoth,
      4 => l10n.activityDormant,
      null => l10n.unavailable,
      _ => 'Activity $activity',
    };

String localizedDbmQuality(AppLocalizations l10n, int dbm) {
  if (dbm >= -80) return l10n.qualityExcellent;
  if (dbm >= -90) return l10n.qualityGood;
  if (dbm >= -100) return l10n.qualityFair;
  if (dbm >= -110) return l10n.qualityPoor;
  return l10n.qualityVeryPoor;
}

String localizedSignalLevel(AppLocalizations l10n, int? level) =>
    switch (level) {
      0 => l10n.signalNone,
      1 => l10n.qualityPoor,
      2 => l10n.qualityFair,
      3 => l10n.qualityGood,
      4 => l10n.qualityExcellent,
      null => l10n.unavailable,
      _ => 'Level $level',
    };

String localizedLatencyQuality(AppLocalizations l10n, int ms) {
  if (ms < 40) return l10n.qualityExcellent;
  if (ms < 80) return l10n.qualityGood;
  if (ms < 150) return l10n.qualityFair;
  return l10n.qualityPoor;
}
