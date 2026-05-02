import 'package:flutter/material.dart';

class AppTheme {
  // ── Core palette from "Premium Dark Stream" Uizard theme ──────────────────
  static const Color primary = Color(0xFF7C4DFF); // Primary #7C4DFF
  static const Color bg = Color(0xFF0A0A0A); // Neutral #0A0A0A
  static const Color surface = Color(0xFF1A1A1A); // Secondary #1A1A1A
  static const Color card = Color(0xFF1A1A1A); // Secondary #1A1A1A
  static const Color tertiary = Color(0xFFFFFFFF); // Tertiary #FFFFFF

  // ── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFFFFFF); // Tertiary full
  static const Color textSecondary = Color(0x99FFFFFF); // white 60%
  static const Color textHint = Color(0x61FFFFFF); // white 38%

  // ── Dividers / borders ───────────────────────────────────────────────────
  static const Color divider = Color(0x1FFFFFFF); // white 12%
  static const Color dividerLight = Color(0x3DFFFFFF); // white 24%

  // ── Legacy aliases (keep for existing widget compatibility) ───────────────
  static const Color accent = primary;
  static const Color accentAlt = Color(0xFFB085FF); // lighter purple tint

  // ── ThemeData ─────────────────────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bg,

    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: accentAlt,
      surface: surface,
      // ignore: deprecated_member_use
      background: bg,
      onPrimary: tertiary,
      onSurface: textPrimary,
      outline: divider,
    ),

    // ── AppBar ─────────────────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: bg,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontFamily: 'BeVietnamPro',
        letterSpacing: -0.5,
      ),
    ),

    // ── Typography (Be Vietnam Pro) ────────────────────────────────────
    textTheme: const TextTheme(
      // Headlines
      headlineLarge: TextStyle(
        color: textPrimary,
        fontFamily: 'BeVietnamPro',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.0,
      ),
      headlineMedium: TextStyle(
        color: textPrimary,
        fontFamily: 'BeVietnamPro',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        color: textPrimary,
        fontFamily: 'BeVietnamPro',
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      // Titles
      titleLarge: TextStyle(
        color: textPrimary,
        fontFamily: 'BeVietnamPro',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: textPrimary,
        fontFamily: 'BeVietnamPro',
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: textSecondary,
        fontFamily: 'BeVietnamPro',
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      // Body
      bodyLarge: TextStyle(
        color: textSecondary,
        fontFamily: 'BeVietnamPro',
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: textSecondary,
        fontFamily: 'BeVietnamPro',
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: textHint,
        fontFamily: 'BeVietnamPro',
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      // Label
      labelLarge: TextStyle(
        color: textPrimary,
        fontFamily: 'BeVietnamPro',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: textSecondary,
        fontFamily: 'BeVietnamPro',
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: textHint,
        fontFamily: 'BeVietnamPro',
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    ),

    // ── Input / Search bar ─────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: divider, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
      hintStyle: const TextStyle(
        color: textHint,
        fontFamily: 'BeVietnamPro',
        fontSize: 14,
      ),
      prefixIconColor: textHint,
      suffixIconColor: textHint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),

    // ── Buttons ────────────────────────────────────────────────────────

    // Primary filled button (purple bg)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: tertiary,
        elevation: 0,
        textStyle: const TextStyle(
          fontFamily: 'BeVietnamPro',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    ),

    // Outlined button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary, width: 1.0),
        textStyle: const TextStyle(
          fontFamily: 'BeVietnamPro',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(
          fontFamily: 'BeVietnamPro',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ── Icon ──────────────────────────────────────────────────────────
    iconTheme: const IconThemeData(color: textSecondary, size: 24),

    // ── Bottom Navigation Bar ─────────────────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF111111),
      selectedItemColor: primary,
      unselectedItemColor: textHint,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontFamily: 'BeVietnamPro',
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'BeVietnamPro',
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    ),

    // ── Card ──────────────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: divider, width: 0.5),
      ),
    ),

    // ── Chip (genre tags) ─────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: surface,
      selectedColor: primary.withOpacity(0.18),
      labelStyle: const TextStyle(
        color: textPrimary,
        fontFamily: 'BeVietnamPro',
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      side: const BorderSide(color: primary, width: 1.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    ),

    // ── Slider (seek bar) ─────────────────────────────────────────────
    sliderTheme: SliderThemeData(
      activeTrackColor: primary,
      inactiveTrackColor: dividerLight,
      thumbColor: tertiary,
      overlayColor: primary.withOpacity(0.20),
      trackHeight: 3.0,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
    ),

    // ── Progress indicator (mini player bar) ──────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primary,
      linearTrackColor: divider,
      linearMinHeight: 2.0,
    ),

    // ── Divider ───────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: divider,
      thickness: 0.5,
      space: 0,
    ),

    // ── List tile ────────────────────────────────────────────────────
    listTileTheme: const ListTileThemeData(
      tileColor: surface,
      iconColor: textSecondary,
      textColor: textPrimary,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    // ── SnackBar ─────────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surface,
      contentTextStyle: const TextStyle(
        color: textPrimary,
        fontFamily: 'BeVietnamPro',
        fontSize: 13,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
