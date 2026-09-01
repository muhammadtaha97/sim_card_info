import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../utils/localized_labels.dart';

/// Live signal display for one subscription: an arc gauge over the dBm range
/// that matters for cellular (-120 … -50), the headline dBm, and the 0–4
/// bars the status bar shows.
class SignalMeter extends StatelessWidget {
  const SignalMeter({
    super.key,
    required this.dbm,
    required this.level,
    this.radio,
  });

  final int? dbm;

  /// The 0–4 bucket; used for colour and as the fallback when dBm is absent.
  final int? level;

  final String? radio;

  static const _minDbm = -120.0;
  static const _maxDbm = -50.0;

  double get _fraction {
    final value = dbm;
    if (value == null) return (level ?? 0) / 4;
    return ((value - _minDbm) / (_maxDbm - _minDbm)).clamp(0.0, 1.0);
  }

  Color _color(BuildContext context) {
    final bucket = level ?? (dbm == null ? 0 : (4 * _fraction).round());
    return switch (bucket) {
      >= 4 => const Color(0xFF2E7D32),
      3 => const Color(0xFF558B2F),
      2 => const Color(0xFFF9A825),
      1 => const Color(0xFFEF6C00),
      _ => Theme.of(context).colorScheme.error,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _color(context);
    return Row(
      children: [
        SizedBox(
          width: 96,
          height: 96,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 96,
                height: 96,
                child: CircularProgressIndicator(
                  value: _fraction,
                  strokeWidth: 8,
                  strokeCap: StrokeCap.round,
                  color: color,
                  backgroundColor:
                      theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dbm != null ? '$dbm' : '—',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                  Text('dBm', style: theme.textTheme.labelSmall),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dbm != null
                    ? localizedDbmQuality(AppLocalizations.of(context), dbm!)
                    : localizedSignalLevel(AppLocalizations.of(context), level),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              if (radio != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(radio!, style: theme.textTheme.bodySmall),
                ),
              const SizedBox(height: 8),
              _Bars(level: level ?? (4 * _fraction).round(), color: color),
            ],
          ),
        ),
      ],
    );
  }
}

class _Bars extends StatelessWidget {
  const _Bars({required this.level, required this.color});

  final int level;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final off = Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 1; i <= 4; i++) ...[
          Container(
            width: 10,
            height: 8.0 + i * 6,
            decoration: BoxDecoration(
              color: i <= level ? color : off,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          if (i < 4) const SizedBox(width: 4),
        ],
      ],
    );
  }
}
