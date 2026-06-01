import 'package:flutter/material.dart';

class AppTheme {
  static const _seed = Color(0xFF6366F1); // indigo-500
  static const _seedDark = Color(0xFF818CF8); // indigo-400

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seed,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF4F4F5),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        titleTextStyle: const TextStyle(
          color: Color(0xFF09090B),
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        iconTheme: const IconThemeData(color: Color(0xFF71717A)),
        actionsIconTheme: const IconThemeData(color: Color(0xFF71717A)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _seed, width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFFA1A1AA), fontSize: 14),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE4E4E7)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFF4F4F5),
        thickness: 1,
        space: 1,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          visualDensity: VisualDensity.compact,
        ),
      ),
      sliderTheme: const SliderThemeData(trackHeight: 3),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedDark,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF09090B),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF09090B),
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        titleTextStyle: const TextStyle(
          color: Color(0xFFFAFAFA),
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        iconTheme: const IconThemeData(color: Color(0xFF71717A)),
        actionsIconTheme: const IconThemeData(color: Color(0xFF71717A)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF18181B),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF27272A)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF27272A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _seedDark, width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFF52525B), fontSize: 14),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF18181B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF27272A)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF1F1F23),
        thickness: 1,
        space: 1,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          visualDensity: VisualDensity.compact,
        ),
      ),
      sliderTheme: const SliderThemeData(trackHeight: 3),
    );
  }
}
