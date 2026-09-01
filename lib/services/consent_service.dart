import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_service.dart';

/// Google's User Messaging Platform consent flow.
///
/// AdMob requires a certified CMP to gather consent before a personalised ad
/// request is made in the EEA, the UK and the regulated US states. This app
/// ships the flow from 1.0.0 rather than retrofitting it, which is what the
/// sibling apps had to do.
///
/// The flow, in the order Google documents it:
///   1. request an update of the consent information (cached across sessions);
///   2. load and show the form, but only if one is required;
///   3. only then ask [ConsentInformation.canRequestAds] whether ads may be
///      requested at all.
///
/// Nothing here throws. A failure anywhere falls back to the cached
/// [canRequestAds] answer, so a user who consented in an earlier session still
/// sees ads when the network is down, and a first-time user in a regulated
/// region does not.
abstract final class ConsentService {
  /// Set true, with [debugTestDeviceIds] filled in, to make a device outside
  /// the EEA behave as though it were inside it. Debug builds only — the flag
  /// is ignored in release so it cannot ship on.
  static const debugForceEea = false;

  /// Hashed device ids from the "Use ConsentDebugSettings.testIdentifiers"
  /// line that UMP logs on the device when a debug geography is set.
  static const debugTestDeviceIds = <String>[];

  /// Beyond this, stop waiting and fall back to the cached consent state. A
  /// form the user never dismisses would otherwise hold ads for the session —
  /// which is the safe direction, but so is respecting an earlier answer.
  static const _timeout = Duration(seconds: 20);

  static final Completer<bool> _completer = Completer<bool>();

  /// Whether the privacy options entry point has to be offered.
  ///
  /// Required in the EEA and the UK once consent has been gathered: the user
  /// must be able to change their mind. False everywhere else, which is why
  /// the button is conditional rather than always on screen.
  static final ValueNotifier<bool> privacyOptionsRequired = ValueNotifier(
    false,
  );

  /// Completes with whether ads may be requested. Always completes.
  static Future<bool> get ready => _completer.future;

  /// Runs the flow. Safe to await; never throws.
  static Future<bool> gather() async {
    if (!adsSupported) {
      _finish(false);
      return false;
    }

    try {
      await _requestUpdate().timeout(_timeout);
      await ConsentForm.loadAndShowConsentFormIfRequired((error) {
        if (error != null) {
          debugPrint('Consent form dismissed with an error: ${error.message}');
        }
      }).timeout(_timeout);
    } on TimeoutException {
      debugPrint('Consent flow timed out after $_timeout');
    } catch (error) {
      debugPrint('Consent flow failed: $error');
    }

    // Asked even after a failure: it reads the state cached from previous
    // sessions, so a returning user's answer still counts.
    final canRequestAds = await _canRequestAds();
    await _refreshPrivacyOptions();
    // Logged because the two answers together are the whole outcome of the
    // flow, and neither is visible from the UI outside a regulated region.
    debugPrint(
      'Consent resolved: canRequestAds=$canRequestAds '
      'privacyOptionsRequired=${privacyOptionsRequired.value}',
    );
    _finish(canRequestAds);
    return canRequestAds;
  }

  /// Reopens the form so the user can change a previous answer.
  ///
  /// Returns an error when the form could not be shown, for the caller to
  /// report — a button that silently does nothing is worse than a message.
  static Future<FormError?> showPrivacyOptions() async {
    final completer = Completer<FormError?>();
    try {
      await ConsentForm.showPrivacyOptionsForm(completer.complete);
      final error = await completer.future.timeout(_timeout);
      await _refreshPrivacyOptions();
      return error;
    } on TimeoutException {
      return null;
    } catch (error) {
      debugPrint('Privacy options form failed: $error');
      return null;
    }
  }

  /// Wraps the callback-style update in a future.
  ///
  /// The zone guard is load-bearing. `requestConsentInfoUpdate` is a
  /// fire-and-forget `void ... async` inside the plugin that only catches
  /// `PlatformException`: anything else — a MissingPluginException, a codec
  /// error — escapes as an unhandled async error, so *neither* listener is
  /// ever called. Without the guard this future never completed, the flow sat
  /// out its full timeout before any ad could load, and CrashReporter recorded
  /// the escaped error as a fatal crash.
  static Future<void> _requestUpdate() {
    final completer = Completer<void>();

    // Completed, never failed: every caller falls back to cached consent.
    void finish([Object? error]) {
      if (error != null) debugPrint('Consent info update failed: $error');
      if (!completer.isCompleted) completer.complete();
    }

    runZonedGuarded(
      () => ConsentInformation.instance.requestConsentInfoUpdate(
        ConsentRequestParameters(
          // kDebugMode is checked here rather than at the constant so a stray
          // `true` cannot change how a release build gathers consent.
          consentDebugSettings: kDebugMode && debugForceEea
              ? ConsentDebugSettings(
                  debugGeography: DebugGeography.debugGeographyEea,
                  testIdentifiers: debugTestDeviceIds,
                )
              : null,
        ),
        finish,
        (error) => finish(error.message),
      ),
      (error, stack) => finish(error),
    );

    return completer.future;
  }

  static Future<bool> _canRequestAds() async {
    try {
      return await ConsentInformation.instance.canRequestAds();
    } catch (error) {
      debugPrint('canRequestAds failed: $error');
      // No answer means no permission to request a personalised ad.
      return false;
    }
  }

  static Future<void> _refreshPrivacyOptions() async {
    try {
      final status = await ConsentInformation.instance
          .getPrivacyOptionsRequirementStatus();
      privacyOptionsRequired.value =
          status == PrivacyOptionsRequirementStatus.required;
    } catch (error) {
      debugPrint('Privacy options requirement status failed: $error');
    }
  }

  static void _finish(bool value) {
    if (!_completer.isCompleted) _completer.complete(value);
  }
}
