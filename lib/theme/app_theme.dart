import 'package:flutter/material.dart';

/// Centralised design tokens so spacing, radii and brand colours stay
/// consistent across the whole app.
class AppTokens {
  AppTokens._();

  static const brand = Color(0xFF6366F1); // indigo-500
  static const brandDark = Color(0xFF818CF8); // indigo-400

  static const radiusSm = 8.0;
  static const radiusMd = 12.0;
  static const radiusLg = 16.0;
  static const radiusXl = 20.0;

  static const gap = 12.0;
  static const gapLg = 16.0;
}

class AppTheme {
  static ThemeData light() => _build(
        brightness: Brightness.light,
        seed: AppTokens.brand,
        scaffold: const Color(0xFFF6F6F8),
        surface: Colors.white,
        surfaceMuted: const Color(0xFFFAFAFB),
        border: const Color(0xFFE7E7EB),
        borderStrong: const Color(0xFFD9D9DF),
        textStrong: const Color(0xFF09090B),
        textMuted: const Color(0xFF71717A),
        trackInactive: const Color(0xFFE4E4EA),
      );

  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        seed: AppTokens.brandDark,
        scaffold: const Color(0xFF09090B),
        surface: const Color(0xFF161619),
        surfaceMuted: const Color(0xFF1B1B1F),
        border: const Color(0xFF27272A),
        borderStrong: const Color(0xFF34343A),
        textStrong: const Color(0xFFFAFAFA),
        textMuted: const Color(0xFFA1A1AA),
        trackInactive: const Color(0xFF2A2A30),
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color seed,
    required Color scaffold,
    required Color surface,
    required Color surfaceMuted,
    required Color border,
    required Color borderStrong,
    required Color textStrong,
    required Color textMuted,
    required Color trackInactive,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    ).copyWith(
      surface: surface,
      outlineVariant: border,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: Border(bottom: BorderSide(color: border)),
        titleTextStyle: TextStyle(
          color: textStrong,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        iconTheme: IconThemeData(color: textMuted),
        actionsIconTheme: IconThemeData(color: textMuted),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceMuted,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: seed, width: 1.5),
        ),
        hintStyle: TextStyle(color: textMuted.withValues(alpha: 0.8), fontSize: 13),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusXl),
          side: BorderSide(color: border),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: border,
        thickness: 1,
        space: 1,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          // A gentle lift on hover so the primary action feels responsive.
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) return 4;
            return 0;
          }),
          shadowColor: WidgetStateProperty.all(
            seed.withValues(alpha: 0.5),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textStrong,
          side: BorderSide(color: borderStrong),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return surface;
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return scheme.primary;
            return textMuted;
          }),
          elevation: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.selected) ? 1 : 0),
          shadowColor: WidgetStateProperty.all(
            Colors.black.withValues(alpha: 0.18),
          ),
          overlayColor:
              WidgetStateProperty.all(scheme.primary.withValues(alpha: 0.06)),
          side: WidgetStateProperty.all(BorderSide.none),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTokens.radiusSm),
            ),
          ),
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: WidgetStateProperty.all(EdgeInsets.zero),
        ),
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 6,
        activeTrackColor: scheme.primary,
        inactiveTrackColor: trackInactive,
        thumbColor: surface,
        overlayColor: scheme.primary.withValues(alpha: 0.12),
        trackShape: const RoundedRectSliderTrackShape(),
        thumbShape: const _BorderedThumbShape(),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
        tickMarkShape: SliderTickMarkShape.noTickMark,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: textStrong,
        contentTextStyle: TextStyle(
          color: scaffold,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        ),
      ),
    );
  }
}

/// A slider thumb with a coloured ring around a surface-coloured core — reads
/// as a crisp, modern control rather than the default flat dot.
class _BorderedThumbShape extends SliderComponentShape {
  const _BorderedThumbShape();

  static const double _radius = 11;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(_radius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final ringColor = sliderTheme.activeTrackColor ?? Colors.indigo;
    final coreColor = sliderTheme.thumbColor ?? Colors.white;

    canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: center, radius: _radius)),
      Colors.black.withValues(alpha: 0.28),
      2,
      true,
    );
    canvas.drawCircle(center, _radius, Paint()..color = ringColor);
    canvas.drawCircle(center, _radius - 3.2, Paint()..color = coreColor);
  }
}
