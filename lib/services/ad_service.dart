/// AdMob wiring: unit ids, SDK startup, and the interstitial.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Ad unit identifiers for the AdMob app
/// `ca-app-pub-9785628886941445~2184752117`.
///
/// All Android units. iOS units are separate and do not exist yet: an Android
/// unit will not serve there, and iOS would also need
/// `GADApplicationIdentifier` in Info.plist before any of this worked.
abstract final class AdUnits {
  /// The AdMob app id, duplicated here from AndroidManifest.xml so the test
  /// suite can assert the two agree.
  ///
  /// Not decoration. These apps share one AdMob publisher account, and pasting
  /// a sibling app's id into a new one is a mistake that has already happened
  /// once in this family: revenue lands under the wrong app and the mistake is
  /// invisible in the console until someone reconciles it by hand.
  static const applicationId = 'ca-app-pub-9785628886941445~2184752117';

  static const publisherPrefix = 'ca-app-pub-9785628886941445';

  /// Flip to true to use Google's test units, which always fill — the only
  /// reliable way to tell "the wiring is broken" from "this unit is new and
  /// has no fill yet". The config test deliberately fails while it is on, so
  /// a build cannot ship with it set.
  static const useTestUnits = false;

  // Live units from the AdMob console (Android).
  static const bannerLive = 'ca-app-pub-9785628886941445/3230345678';
  static const interstitialLive = 'ca-app-pub-9785628886941445/1689928098';

  // Google's documented Android test units. iOS has its own; these will not
  // serve there.
  static const bannerTest = 'ca-app-pub-3940256099942544/6300978111';
  static const interstitialTest = 'ca-app-pub-3940256099942544/1033173712';

  static const banner = useTestUnits ? bannerTest : bannerLive;
  static const interstitial = useTestUnits
      ? interstitialTest
      : interstitialLive;

  static bool get bannerIsTestUnit => banner == bannerTest;
  static bool get interstitialIsTestUnit => interstitial == interstitialTest;

  /// Release gate: a shipped test unit earns nothing and is not permitted in
  /// production. Asserted in the test suite so it cannot slip through.
  static bool get anyTestUnit => bannerIsTestUnit || interstitialIsTestUnit;

  /// Every id this app owns, for the collision check in the test suite.
  static const allOwnUnits = [bannerLive, interstitialLive];
}

/// Compile-time kill switch for store-listing screenshot sessions:
/// `flutter build apk --dart-define=SCREENSHOT_MODE=true` produces a build
/// where the ads SDK never starts, so no banner can wander into a capture.
/// Defaults to false, so a normal build is unaffected.
const bool kScreenshotMode = bool.fromEnvironment('SCREENSHOT_MODE');

/// True on the platforms where the ads SDK is actually supported.
bool get adsSupported =>
    !kScreenshotMode &&
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);

/// One-time SDK startup that ad requests can wait on.
///
/// Do NOT await [init] from the startup path. Initialization has been measured
/// at tens of seconds on a slow device, and awaiting it in main() would delay
/// first paint by the same amount. Kick it off and let ad loads wait on
/// [ready].
///
/// Consent comes first: see ConsentService, which decides whether [init] is
/// allowed to start the SDK at all.
abstract final class AdsBootstrap {
  static final Completer<bool> _completer = Completer<bool>();

  /// Beyond this, treat the SDK as unavailable rather than leaving every ad
  /// load waiting on a future that may never complete.
  static const _initTimeout = Duration(seconds: 30);

  /// Completes with whether the SDK came up. Always completes.
  static Future<bool> get ready => _completer.future;

  /// [canRequestAds] is the answer from the UMP consent flow. When it is false
  /// the SDK is not started at all, so nothing downstream can request an ad the
  /// user has not consented to.
  static Future<void> init({required bool canRequestAds}) async {
    if (!adsSupported || !canRequestAds) {
      _finish(false);
      return;
    }
    try {
      await MobileAds.instance.initialize().timeout(_initTimeout);
      _finish(true);
    } on TimeoutException {
      debugPrint('MobileAds init timed out after $_initTimeout');
      _finish(false);
    } catch (error) {
      debugPrint('MobileAds init failed: $error');
      _finish(false);
    }
  }

  static void _finish(bool value) {
    if (!_completer.isCompleted) _completer.complete(value);
  }
}

/// Backoff schedule shared by both formats.
///
/// No-fill is normal for a new unit and on a cold start, so both formats retry
/// rather than treating one failure as final for the session.
const List<Duration> kAdRetryBackoff = [
  Duration(seconds: 4),
  Duration(seconds: 15),
  Duration(seconds: 45),
];

/// Keeps one interstitial ready and hands it out at most once per request.
class InterstitialAdService {
  InterstitialAd? _ad;
  bool _isLoading = false;
  bool _disposed = false;
  int _attempt = 0;
  Timer? _retryTimer;
  VoidCallback? _pendingDismiss;

  bool get isReady => _ad != null;

  Future<void> load() async {
    if (!adsSupported || _disposed || _isLoading || _ad != null) return;
    _isLoading = true;

    // Wait for the SDK rather than racing it.
    if (!await AdsBootstrap.ready) {
      _isLoading = false;
      return;
    }
    if (_disposed) {
      _isLoading = false;
      return;
    }

    InterstitialAd.load(
      adUnitId: AdUnits.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoading = false;
          _attempt = 0;
          if (_disposed) {
            ad.dispose();
            return;
          }
          _ad = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _ad = null;
              _attempt = 0;
              _fireDismiss();
              load();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Interstitial failed to show: $error');
              ad.dispose();
              _ad = null;
              _attempt = 0;
              _fireDismiss();
              load();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          _ad = null;
          debugPrint('Interstitial failed to load: $error');
          _scheduleRetry();
        },
      ),
    );
  }

  /// Shows the ad if one is ready, returning whether it was shown.
  ///
  /// [onDismissed] runs once the ad closes, so a caller can defer navigation
  /// until the user is back — ad first, then destination.
  bool show({VoidCallback? onDismissed}) {
    final ad = _ad;
    if (ad == null) return false;
    // Cleared first so a second call in the same frame cannot show a disposed
    // ad.
    _ad = null;
    _pendingDismiss = onDismissed;
    ad.show();
    return true;
  }

  /// Retries a few times with backoff, then stops rather than hammering.
  void _scheduleRetry() {
    if (_disposed || _attempt >= kAdRetryBackoff.length) return;
    final delay = kAdRetryBackoff[_attempt++];
    _retryTimer?.cancel();
    _retryTimer = Timer(delay, load);
  }

  void _fireDismiss() {
    final callback = _pendingDismiss;
    _pendingDismiss = null;
    callback?.call();
  }

  void dispose() {
    _disposed = true;
    _retryTimer?.cancel();
    _pendingDismiss = null;
    _ad?.dispose();
    _ad = null;
  }
}

/// Decides when an interstitial is allowed to appear.
///
/// Kept out of the screen so the policy is stated in one place and can be
/// tested without a widget. The policy: never on the first few actions, then
/// at most one every [_minInterval], and never while the user is mid-task —
/// the caller only asks after an action has completed successfully.
class InterstitialPolicy {
  InterstitialPolicy({DateTime? now}) : _lastShown = now;

  /// Actions before the first interstitial is even considered.
  ///
  /// A user who is interrupted by a full-screen ad the first time they try an
  /// app uninstalls it. Three actions in, they have had the value.
  static const warmupActions = 3;

  static const _minInterval = Duration(minutes: 2);

  int _actions = 0;
  DateTime? _lastShown;

  /// Records a completed action and says whether an ad may be shown now.
  bool shouldShow({DateTime? now}) {
    _actions++;
    if (_actions <= warmupActions) return false;
    final at = now ?? DateTime.now();
    final last = _lastShown;
    if (last != null && at.difference(last) < _minInterval) return false;
    _lastShown = at;
    return true;
  }
}
