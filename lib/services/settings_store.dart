import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The app's persisted preferences: just the theme mode for now.
///
/// Defaults to following the system, which a 1.0.0 can do safely — there is
/// no installed base whose remembered light/dark choice would change meaning.
class SettingsStore extends ChangeNotifier {
  SettingsStore(this._prefs);

  static const _themeModeKey = 'theme_mode';
  static const _localeKey = 'app_locale';
  static const _requestedPhonePermissionKey = 'requested_phone_permission';
  static const _requestedLocationPermissionKey = 'requested_location_permission';
  static const _cellTowersEnabledKey = 'cell_towers_enabled';

  final SharedPreferences _prefs;

  static Future<SettingsStore> load() async =>
      SettingsStore(await SharedPreferences.getInstance());

  ThemeMode get themeMode => switch (_prefs.getString(_themeModeKey)) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  /// The in-app language override; null means "follow the system", which is
  /// the default and the only state a fresh install has.
  Locale? get localeOverride {
    final tag = _prefs.getString(_localeKey);
    return (tag == null || tag.isEmpty) ? null : Locale(tag);
  }

  Future<void> setLocaleOverride(Locale? locale) async {
    if (locale == null) {
      await _prefs.remove(_localeKey);
    } else {
      await _prefs.setString(_localeKey, locale.languageCode);
    }
    notifyListeners();
  }

  /// Whether the permission dialog has ever been requested.
  ///
  /// Needed because `shouldShowRequestPermissionRationale` is false both
  /// before the first request and after a permanent denial — without this
  /// flag a fresh install would be told "denied permanently" and sent to the
  /// settings screen instead of getting the system dialog.
  bool get hasRequestedPhonePermission =>
      _prefs.getBool(_requestedPhonePermissionKey) ?? false;

  Future<void> markPhonePermissionRequested() async {
    await _prefs.setBool(_requestedPhonePermissionKey, true);
    notifyListeners();
  }

  /// Same flag for the location permission behind the cell towers section.
  bool get hasRequestedLocationPermission =>
      _prefs.getBool(_requestedLocationPermissionKey) ?? false;

  Future<void> markLocationPermissionRequested() async {
    await _prefs.setBool(_requestedLocationPermissionKey, true);
    notifyListeners();
  }

  /// Whether the user has opted in to the cell towers section. Off by
  /// default — it is the section that costs the location permission.
  bool get cellTowersEnabled =>
      _prefs.getBool(_cellTowersEnabledKey) ?? false;

  Future<void> setCellTowersEnabled(bool value) async {
    await _prefs.setBool(_cellTowersEnabledKey, value);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_themeModeKey, switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    });
    notifyListeners();
  }
}
