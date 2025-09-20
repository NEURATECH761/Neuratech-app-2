import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the e-learning application.
/// Implements Dark Academic Professional theme with Contemporary Professional Minimalism design style.
class AppTheme {
  AppTheme._();

  // Dark Academic Professional Color Palette
  static const Color primaryDark =
      Color(0xFF1A1B23); // Deep charcoal background
  static const Color secondaryDark =
      Color(0xFF2A2D3A); // Elevated surface color
  static const Color accentCoral = Color(0xFFFF6B6B); // Vibrant coral for CTAs
  static const Color successTeal =
      Color(0xFF4ECDC4); // Soft teal for completion
  static const Color warningYellow =
      Color(0xFFFFE66D); // Warm yellow for attention
  static const Color errorSoft = Color(0xFFFF8E8E); // Softened red for errors
  static const Color textPrimary = Color(0xFFFFFFFF); // Pure white for content
  static const Color textSecondary =
      Color(0xFFB8BCC8); // Muted gray for supporting text
  static const Color textTertiary =
      Color(0xFF6C7293); // Subtle gray for inactive states
  static const Color borderColor = Color(0xFF3A3D4A); // Minimal border color

  // Additional surface colors for depth
  static const Color surfaceElevated = Color(0xFF2A2D3A);
  static const Color surfaceCard = Color(0xFF1E2028);
  static const Color surfaceDialog = Color(0xFF2D3142);

  // Shadow colors with appropriate opacity
  static const Color shadowColor =
      Color(0x33000000); // 20% opacity for subtle depth
  static const Color dividerColorDark = Color(0xFF3A3D4A);

  /// Main dark theme optimized for extended mobile reading sessions
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: accentCoral,
      onPrimary: textPrimary,
      primaryContainer: accentCoral.withAlpha(51),
      onPrimaryContainer: textPrimary,
      secondary: successTeal,
      onSecondary: primaryDark,
      secondaryContainer: successTeal.withAlpha(51),
      onSecondaryContainer: textPrimary,
      tertiary: warningYellow,
      onTertiary: primaryDark,
      tertiaryContainer: warningYellow.withAlpha(51),
      onTertiaryContainer: textPrimary,
      error: errorSoft,
      onError: textPrimary,
      surface: primaryDark,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      outline: borderColor,
      outlineVariant: borderColor.withAlpha(128),
      shadow: shadowColor,
      scrim: shadowColor,
      inverseSurface: textPrimary,
      onInverseSurface: primaryDark,
      inversePrimary: accentCoral,
    ),
    scaffoldBackgroundColor: primaryDark,
    cardColor: surfaceCard,
    dividerColor: dividerColorDark,

    // AppBar theme for clean, professional navigation
    appBarTheme: AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: textPrimary,
      elevation: 0,
      shadowColor: shadowColor,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: 0.15,
      ),
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),
    ),

    // Card theme with subtle elevation
    cardTheme: CardTheme(
      color: surfaceCard,
      elevation: 2,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Bottom navigation optimized for one-handed mobile interaction
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: secondaryDark,
      selectedItemColor: accentCoral,
      unselectedItemColor: textTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    ),

    // Floating action button for primary learning actions
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentCoral,
      foregroundColor: textPrimary,
      elevation: 6,
      focusElevation: 8,
      hoverElevation: 8,
      highlightElevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // Button themes with consistent coral accent
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: textPrimary,
        backgroundColor: accentCoral,
        disabledForegroundColor: textTertiary,
        disabledBackgroundColor: textTertiary.withAlpha(51),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentCoral,
        disabledForegroundColor: textTertiary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: accentCoral, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentCoral,
        disabledForegroundColor: textTertiary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),

    // Typography using Inter font family for consistency
    textTheme: _buildTextTheme(),

    // Input decoration optimized for dark theme readability
    inputDecorationTheme: InputDecorationTheme(
      fillColor: secondaryDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentCoral, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorSoft, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorSoft, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textTertiary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorSoft,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Interactive elements with coral accent
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentCoral;
        }
        return textTertiary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentCoral.withAlpha(128);
        }
        return textTertiary.withAlpha(77);
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentCoral;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(textPrimary),
      side: const BorderSide(color: borderColor, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentCoral;
        }
        return textTertiary;
      }),
    ),

    // Progress indicators using coral accent
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: accentCoral,
      linearTrackColor: borderColor,
      circularTrackColor: borderColor,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: accentCoral,
      thumbColor: accentCoral,
      overlayColor: accentCoral.withAlpha(51),
      inactiveTrackColor: borderColor,
      valueIndicatorColor: accentCoral,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Tab bar theme for course navigation
    tabBarTheme: TabBarTheme(
      labelColor: accentCoral,
      unselectedLabelColor: textSecondary,
      indicatorColor: accentCoral,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
    ),

    // Tooltip theme for helpful information
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: surfaceDialog,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      textStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Snackbar theme for user feedback
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceDialog,
      contentTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentCoral,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 6,
    ),

    // Dialog theme for modal interactions
    dialogTheme: DialogTheme(
      backgroundColor: surfaceDialog,
      elevation: 8,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      titleTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      contentTextStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
    ),

    // Divider theme for content separation
    dividerTheme: const DividerThemeData(
      color: borderColor,
      thickness: 1,
      space: 1,
    ),

    // List tile theme for course listings
    listTileTheme: ListTileThemeData(
      tileColor: surfaceCard,
      selectedTileColor: accentCoral.withAlpha(26),
      iconColor: textSecondary,
      textColor: textPrimary,
      titleTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitleTextStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  );

  /// Light theme (minimal implementation for fallback)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: accentCoral,
      onPrimary: textPrimary,
      primaryContainer: accentCoral.withAlpha(26),
      onPrimaryContainer: primaryDark,
      secondary: successTeal,
      onSecondary: textPrimary,
      secondaryContainer: successTeal.withAlpha(26),
      onSecondaryContainer: primaryDark,
      tertiary: warningYellow,
      onTertiary: primaryDark,
      tertiaryContainer: warningYellow.withAlpha(26),
      onTertiaryContainer: primaryDark,
      error: errorSoft,
      onError: textPrimary,
      surface: textPrimary,
      onSurface: primaryDark,
      onSurfaceVariant: textSecondary,
      outline: borderColor,
      outlineVariant: borderColor.withAlpha(128),
      shadow: shadowColor,
      scrim: shadowColor,
      inverseSurface: primaryDark,
      onInverseSurface: textPrimary,
      inversePrimary: accentCoral,
    ),
    textTheme: _buildTextTheme(isLight: true),
  );

  /// Build text theme using Inter font family with proper hierarchy
  static TextTheme _buildTextTheme({bool isLight = false}) {
    final Color textColor = isLight ? primaryDark : textPrimary;
    final Color textColorSecondary =
        isLight ? primaryDark.withAlpha(179) : textSecondary;
    final Color textColorTertiary =
        isLight ? primaryDark.withAlpha(128) : textTertiary;

    return TextTheme(
      // Display styles for large headings
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: textColor,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: textColor,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0,
        height: 1.22,
      ),

      // Headline styles for section headers
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0,
        height: 1.33,
      ),

      // Title styles for course titles and important content
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Body styles for main content
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColorSecondary,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      // Label styles for buttons and metadata
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColorSecondary,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColorTertiary,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  /// Data text theme using JetBrains Mono for progress statistics and numerical data
  static TextTheme get dataTextTheme {
    return TextTheme(
      bodyLarge: GoogleFonts.jetBrainsMono(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0,
        height: 1.50,
      ),
      bodyMedium: GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        letterSpacing: 0,
        height: 1.33,
      ),
      labelLarge: GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: accentCoral,
        letterSpacing: 0,
        height: 1.43,
      ),
    );
  }

  /// Box shadow configurations for subtle depth
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: shadowColor,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: shadowColor,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get floatingShadow => [
        BoxShadow(
          color: shadowColor,
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ];
}
