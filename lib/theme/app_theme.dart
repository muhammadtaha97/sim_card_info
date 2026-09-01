import 'package:flutter/material.dart';

/// The app's visual identity: Material 3 seeded from a deep telecom teal,
/// with a gold accent that echoes a SIM's contact chip.
abstract final class AppTheme {
  static const seed = Color(0xFF006A60);

  /// Gradients for the SIM card visuals, keyed by slot so a dual-SIM phone
  /// shows two instantly distinguishable cards. eSIMs get their own colour
  /// regardless of slot, because "which of these is the eSIM" is the first
  /// question on a mixed device.
  static const slotGradients = <List<Color>>[
    [Color(0xFF00695C), Color(0xFF00897B)],
    [Color(0xFF283593), Color(0xFF3949AB)],
    [Color(0xFF4527A0), Color(0xFF5E35B1)],
  ];

  static const esimGradient = [Color(0xFF6A1B9A), Color(0xFF8E24AA)];

  /// The chip-gold accent used on the SIM visuals.
  static const chipGold = Color(0xFFE6C36A);

  static List<Color> gradientFor({required int slotIndex, bool isEmbedded = false}) {
    if (isEmbedded) return esimGradient;
    final index = slotIndex < 0 ? 0 : slotIndex % slotGradients.length;
    return slotGradients[index];
  }

  static ThemeData light() => _theme(Brightness.light);

  static ThemeData dark() => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // Cards carry almost all content in this app; one shared shape keeps
      // the four tabs looking like one product.
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: scheme.secondaryContainer,
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant.withValues(alpha: 0.5),
        space: 1,
      ),
    );
  }
}
