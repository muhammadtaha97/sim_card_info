import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/sim_card.dart';
import '../theme/app_theme.dart';
import '../utils/countries.dart';
import '../utils/labels.dart';

/// The hero visual: one subscription drawn as a physical SIM card — gradient
/// body, clipped corner, gold contact chip — so a dual-SIM screen reads at a
/// glance which card is which.
class SimCardVisual extends StatelessWidget {
  const SimCardVisual({super.key, required this.sim});

  final SimCard sim;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppTheme.gradientFor(
      slotIndex: sim.slotIndex,
      isEmbedded: sim.isEmbedded ?? false,
    );
    final flag = countryFlag(sim.countryIso);
    final generation = networkGeneration(sim.dataNetworkType);
    final roles = [
      if (sim.isDefaultData) l10n.chipData,
      if (sim.isDefaultVoice) l10n.labelCalls,
      if (sim.isDefaultSms) l10n.labelSms,
    ];

    return AspectRatio(
      aspectRatio: 1.75,
      child: ClipPath(
        clipper: _SimCornerClipper(),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _ContactChip(),
                      const Spacer(),
                      _Badge(
                        text: (sim.isEmbedded ?? false)
                            ? 'eSIM'
                            : l10n.simN(sim.slotIndex + 1),
                      ),
                      if (sim.isRoaming ?? false) ...[
                        const SizedBox(width: 6),
                        _Badge(text: l10n.labelRoaming),
                      ],
                      if (generation != null) ...[
                        const SizedBox(width: 6),
                        _Badge(text: generation),
                      ],
                    ],
                  ),
                  const Spacer(),
                  Text(
                    sim.carrierName ??
                        sim.displayName ??
                        AppLocalizations.of(context).unknown,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (flag != null) ...[
                        Text(flag, style: const TextStyle(fontSize: 15)),
                        const SizedBox(width: 6),
                      ],
                      Expanded(
                        child: Text(
                          [
                            countryName(sim.countryIso),
                            if (sim.plmn != null) sim.plmn!,
                          ].join('  ·  '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          sim.number ??
                              AppLocalizations.of(context).unavailable,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontFeatures: const [FontFeature.tabularFigures()],
                            letterSpacing: 1.1,
                            color: sim.number == null
                                ? Colors.white.withValues(alpha: 0.6)
                                : Colors.white,
                          ),
                        ),
                      ),
                      for (final role in roles) ...[
                        const SizedBox(width: 6),
                        _Badge(text: role, filled: true),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The gold contact pad, drawn rather than shipped as an image.
class _ContactChip extends StatelessWidget {
  const _ContactChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.chipGold, Color(0xFFC9A24B)],
        ),
      ),
      child: CustomPaint(painter: _ChipLinesPainter()),
    );
  }
}

class _ChipLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x66795A17)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final thirdW = size.width / 3;
    final thirdH = size.height / 3;
    canvas.drawLine(Offset(thirdW, 0), Offset(thirdW, size.height), paint);
    canvas.drawLine(
        Offset(2 * thirdW, 0), Offset(2 * thirdW, size.height), paint);
    canvas.drawLine(Offset(0, thirdH), Offset(size.width, thirdH), paint);
    canvas.drawLine(
        Offset(0, 2 * thirdH), Offset(size.width, 2 * thirdH), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, this.filled = false});

  final String text;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: filled ? Colors.white.withValues(alpha: 0.22) : null,
        border: filled
            ? null
            : Border.all(color: Colors.white.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Rounds every corner and cuts the top-right one flat, the way the plastic
/// is cut on a physical SIM.
class _SimCornerClipper extends CustomClipper<Path> {
  static const _radius = 20.0;
  static const _cut = 34.0;

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(_radius, 0)
      ..lineTo(size.width - _cut, 0)
      ..lineTo(size.width, _cut)
      ..lineTo(size.width, size.height - _radius)
      ..quadraticBezierTo(
          size.width, size.height, size.width - _radius, size.height)
      ..lineTo(_radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - _radius)
      ..lineTo(0, _radius)
      ..quadraticBezierTo(0, 0, _radius, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
