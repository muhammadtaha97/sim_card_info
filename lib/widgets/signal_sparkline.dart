import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../services/signal_history.dart';

/// The last few minutes of dBm readings as a small line chart under the
/// gauge, so a walk around the flat shows where the signal actually drops.
class SignalSparkline extends StatelessWidget {
  const SignalSparkline({super.key, required this.samples});

  final List<SignalSample> samples;

  static const _minDbm = -120.0;
  static const _maxDbm = -50.0;

  @override
  Widget build(BuildContext context) {
    // A line needs two points; before that the widget takes no space rather
    // than reserving an empty strip.
    if (samples.length < 2) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final minutes =
        samples.last.at.difference(samples.first.at).inSeconds / 60.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 44,
          width: double.infinity,
          child: CustomPaint(
            painter: _SparklinePainter(
              samples: samples,
              lineColor: theme.colorScheme.primary,
              fillColor: theme.colorScheme.primary.withValues(alpha: 0.15),
              gridColor: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context);
            final window = minutes < 1
                ? l10n.windowMinute
                : l10n.windowMinutes(minutes.round());
            return Text(
              l10n.sparklineCaption(samples.last.dbm, window),
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            );
          },
        ),
      ],
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({
    required this.samples,
    required this.lineColor,
    required this.fillColor,
    required this.gridColor,
  });

  final List<SignalSample> samples;
  final Color lineColor;
  final Color fillColor;
  final Color gridColor;

  double _y(int dbm, Size size) {
    final t = ((dbm - SignalSparkline._minDbm) /
            (SignalSparkline._maxDbm - SignalSparkline._minDbm))
        .clamp(0.0, 1.0);
    return size.height * (1 - t);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), grid);
    canvas.drawLine(Offset.zero, Offset(size.width, 0), grid);

    // X spacing by sample index, not wall time: a gap while the tab was
    // hidden would otherwise compress everything visible into a corner.
    final step = size.width / (samples.length - 1);
    final path = Path()..moveTo(0, _y(samples.first.dbm, size));
    for (var i = 1; i < samples.length; i++) {
      path.lineTo(step * i, _y(samples[i].dbm, size));
    }

    final fill = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(fill, Paint()..color = fillColor);
    canvas.drawPath(
      path,
      Paint()
        ..color = lineColor
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round,
    );

    final last = Offset(size.width, _y(samples.last.dbm, size));
    canvas.drawCircle(last, 3, Paint()..color = lineColor);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) =>
      oldDelegate.samples != samples;
}
