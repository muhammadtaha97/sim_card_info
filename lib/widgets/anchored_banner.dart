import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_service.dart';

/// Adaptive anchored banner pinned below the scrolling content.
///
/// Anchored rather than inline so it never moves under the user's thumb while
/// they scroll, and it occupies zero height until an ad actually loads — a
/// reserved-but-empty strip would just be dead space on the many sessions
/// where no fill arrives. It sits above the navigation bar, below the content,
/// so a SIM's details are never the thing that gets pushed off screen.
class AnchoredBanner extends StatefulWidget {
  const AnchoredBanner({super.key});

  @override
  State<AnchoredBanner> createState() => _AnchoredBannerState();
}

class _AnchoredBannerState extends State<AnchoredBanner> {
  BannerAd? _ad;
  bool _loaded = false;
  bool _requesting = false;
  double? _lastWidth;
  int _failures = 0;
  Timer? _retryTimer;

  /// Stop after the backoff schedule is spent. Without a terminal state the
  /// widget re-requested forever: build() schedules a load, a failure calls
  /// setState, the rebuild schedules another load. That loop bypassed the
  /// retry counter entirely and hammered AdMob continuously — battery drain
  /// and an invalid-traffic risk on the account.
  bool get _exhausted => _failures >= kAdRetryBackoff.length;

  @override
  void dispose() {
    _retryTimer?.cancel();
    _ad?.dispose();
    super.dispose();
  }

  /// Called from build. Only a genuinely new width may start a request; every
  /// retry goes through [_scheduleRetry] so the cap always applies.
  void _onWidth(double width) {
    if (width <= 0 || width == _lastWidth) return;
    _lastWidth = width;
    _failures = 0;
    _retryTimer?.cancel();
    _load(width);
  }

  Future<void> _load(double width) async {
    if (!adsSupported || _requesting || _exhausted || !mounted) return;

    _requesting = true;

    // Wait for the SDK rather than racing it.
    if (!await AdsBootstrap.ready || !mounted) {
      _requesting = false;
      return;
    }

    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(
      width.truncate(),
    );
    if (size == null || !mounted) {
      _requesting = false;
      return;
    }

    _ad?.dispose();
    _loaded = false;

    final ad = BannerAd(
      adUnitId: AdUnits.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          _requesting = false;
          _failures = 0;
          if (!mounted) return;
          setState(() => _loaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner failed to load: $error');
          ad.dispose();
          _requesting = false;
          _failures++;
          if (!mounted) return;
          setState(() {
            _ad = null;
            _loaded = false;
          });
          _scheduleRetry(width);
        },
      ),
    );

    _ad = ad;
    await ad.load();
  }

  /// Retries on the backoff schedule, then gives up quietly for this width.
  void _scheduleRetry(double width) {
    if (!mounted || _exhausted) return;
    final delay = kAdRetryBackoff[_failures - 1];
    _retryTimer?.cancel();
    _retryTimer = Timer(delay, () {
      if (mounted) _load(width);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Kick the request after layout, never during build.
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _onWidth(constraints.maxWidth),
        );

        final ad = _ad;
        if (!_loaded || ad == null) return const SizedBox.shrink();

        return Container(
          alignment: Alignment.center,
          // A hairline above separates the ad from app content, which is both
          // clearer and what AdMob's placement guidance asks for.
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
          ),
          width: ad.size.width.toDouble(),
          height: ad.size.height.toDouble(),
          child: AdWidget(ad: ad),
        );
      },
    );
  }
}
