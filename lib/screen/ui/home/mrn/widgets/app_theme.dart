// lib/constants/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  //  Core palette 
  static const Color navy            = Color(0xFF0C1A2E);
  static const Color primaryNavy     = Color(0xFF0C1A2E);
  static const Color primaryBlue     = Color(0xFF2563EB);
  static const Color primaryBlueDark = Color(0xFF1D4ED8);
  static const Color primaryBlueLight= Color(0xFFEFF6FF);

  //  Backgrounds 
  /// Default scaffold background — light blue-grey (Figma dashboard)
  static const Color background      = Color(0xFFFDFDFD);
  /// Pure white — cards, modals, surfaces
  static const Color surface         = Color(0xFFFFFFFF);
  static const Color white           = Color(0xFFFFFFFF);

  //  Borders 
  static const Color border          = Color(0xFFE2E8F0);
  static const Color borderDark      = Color(0xFFCBD5E1);
  /// Ultra-light divider used inside cards (Figma row separators)
  static const Color divider         = Color(0xFFF8FAFC);

  //  Text 
  static const Color textPrimary     = Color(0xFF1A1D2E);
  static const Color textSecondary   = Color(0xFF7B82A0);
  static const Color textMuted       = Color(0xFF94A3B8);
  static const Color textTertiary    = Color(0xFF94A3B8);

  //  Semantic 
  static const Color success         = Color(0xFF22C55E);
  static final Color successLight    = const Color(0xFF22C55E).withValues(alpha: 0.12);
  static const Color warning         = Color(0xFFF59E0B);
  static final Color warningLight    = const Color(0xFFF59E0B).withValues(alpha: 0.12);
  static const Color error           = Color(0xFFEF4444);
  static final Color errorLight      = const Color(0xFFEF4444).withValues(alpha: 0.12);
  static const Color info            = Color(0xFF3B82F6);
  static final Color infoLight       = const Color(0xFF3B82F6).withValues(alpha: 0.12);
  static const Color orange          = Color(0xFFF97316);
  static final Color orangeLight     = const Color(0xFFF97316).withValues(alpha: 0.12);

  //  Brand purple / indigo (Figma primary) 
  /// Primary indigo — hero card, active tabs, links, FAB
  static const Color purple          = Color(0xFF5B6CF6);
  static final Color purpleLight     = const Color(0xFF5B6CF6).withValues(alpha: 0.10);
  static final Color purpleLightest  = const Color(0xFF5B6CF6).withValues(alpha: 0.05);

  //  Shimmer 
  static const Color shimmerBase      = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF8FAFC);

  //  Shadows 
  /// Standard card shadow — soft blue-tinted (used on every white card)
  static BoxShadow get cardShadow => BoxShadow(
    color: const Color(0xFF8895C5).withValues(alpha: 0.13),
    blurRadius: 18,
    spreadRadius: 0,
    offset: const Offset(0, 4),
  );

  /// Hero / prominent card shadow — purple glow
  static BoxShadow get heroShadow => BoxShadow(
    color: const Color(0xFF5B6CF6).withValues(alpha: 0.28),
    blurRadius: 24,
    spreadRadius: 0,
    offset: const Offset(0, 8),
  );

  /// Subtle shadow for bottom sheets / modals
  static BoxShadow get sheetShadow => BoxShadow(
    color: const Color(0xFF8895C5).withValues(alpha: 0.08),
    blurRadius: 24,
    spreadRadius: 0,
    offset: const Offset(0, -4),
  );

  //  Status helpers 
  static Color forStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'open':
        return warning;
      case 'approved':
      case 'completed':
      case 'present':
      case 'received':
      case 'close':
      case 'closed':
        return success;
      case 'rejected':
      case 'absent':
        return error;
      case 'in progress':
      case 'submitted':
        return info;
      case 'draft':
        return textMuted;
      default:
        return purple;
    }
  }

  static Color forStatusLight(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'open':
        return warningLight;
      case 'approved':
      case 'completed':
      case 'present':
      case 'close':
      case 'closed':
        return successLight;
      case 'rejected':
      case 'absent':
        return errorLight;
      case 'in progress':
      case 'submitted':
        return infoLight;
      case 'draft':
        return border;
      default:
        return purpleLight;
    }
  }
}

//  Status color extension 
extension StatusColorExt on String {
  Color get statusColor      => AppColors.forStatus(this);
  Color get statusBgColor    => AppColors.forStatusLight(this);
  Color get statusColorLight => AppColors.forStatusLight(this);
}

//  Text styles 
class AppTextStyles {
  AppTextStyles._();

  // Display
  static TextStyle get h1 => GoogleFonts.plusJakartaSans(
      fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary,
      letterSpacing: -0.3);
  static TextStyle get h2 => GoogleFonts.plusJakartaSans(
      fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary,
      letterSpacing: -0.3);
  static TextStyle get h3 => GoogleFonts.plusJakartaSans(
      fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary,
      letterSpacing: -0.2);
  static TextStyle get h4 => GoogleFonts.plusJakartaSans(
      fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  // Body
  static TextStyle get body => GoogleFonts.plusJakartaSans(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static TextStyle get bodyMedium => GoogleFonts.plusJakartaSans(
      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary);

  // Caption
  static TextStyle get caption => GoogleFonts.plusJakartaSans(
      fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondary);
  static TextStyle get captionMedium => GoogleFonts.plusJakartaSans(
      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary);

  // Functional helpers
  static TextStyle label({
    Color color = AppColors.textSecondary,
    FontWeight weight = FontWeight.w500,
  }) =>
      GoogleFonts.plusJakartaSans(
          fontSize: 12, fontWeight: weight, color: color, letterSpacing: 0.4);

  static TextStyle bodySmall({
    Color color = AppColors.textSecondary,
    FontWeight weight = FontWeight.w400,
  }) =>
      GoogleFonts.plusJakartaSans(
          fontSize: 12, fontWeight: weight, color: color, height: 1.4);

  static TextStyle button({Color color = Colors.white}) =>
      GoogleFonts.plusJakartaSans(
          fontSize: 15, fontWeight: FontWeight.w600, color: color);

  // Mono (for IDs, codes)
  static TextStyle get mono => const TextStyle(
      fontFamily: 'JetBrainsMono',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary);
}

//  Box decorations 
class AppDecorations {
  AppDecorations._();

  /// Standard white card — shadow only, no border (Figma standard)
  static BoxDecoration card({double radius = 16}) => BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [AppColors.cardShadow],
  );

  /// Card with a visible border (legacy / list items)
  static BoxDecoration cardBordered({double radius = 12}) => BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: AppColors.border),
  );

  /// Deep navy gradient — headers, auth screens
  static BoxDecoration navyGradient({double radius = 16}) => BoxDecoration(
    gradient: const LinearGradient(
        colors: [Color(0xFF0C1A2E), Color(0xFF1E3A5F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    borderRadius: BorderRadius.circular(radius),
  );

  /// Blue gradient — CTA buttons, promo banners
  static BoxDecoration blueGradient({double radius = 16}) => BoxDecoration(
    gradient: const LinearGradient(
        colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    borderRadius: BorderRadius.circular(radius),
  );

  /// Indigo/purple gradient — hero cards, profile banners (Figma)
  static BoxDecoration indigoGradient({double radius = 20}) => BoxDecoration(
    gradient: const LinearGradient(
        colors: [Color(0xFF5B6CF6), Color(0xFF6C7CF7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [AppColors.heroShadow],
  );
}

//  Theme 
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.purple,
        brightness: Brightness.light,
        primary: AppColors.purple,
        secondary: AppColors.navy,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'PlusJakartaSans',

      // AppBar — flat, bg matches scaffold
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: AppTextStyles.h2,
      ),

      // Cards — shadow only, no border
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),

      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
          textStyle: AppTextStyles.button(),
        ),
      ),

      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.purple,
          minimumSize: const Size(double.infinity, 50),
          side: const BorderSide(color: AppColors.purple, width: 1.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
        ),
      ),

      // Input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide:
            const BorderSide(color: AppColors.purple, width: 1.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AppColors.error)),
        labelStyle:
        AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        hintStyle:
        AppTextStyles.body.copyWith(color: AppColors.textMuted),
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.purpleLight,
        labelStyle:
        AppTextStyles.captionMedium.copyWith(color: AppColors.purple),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.navy,
        contentTextStyle:
        AppTextStyles.body.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)),
        behavior: SnackBarBehavior.floating,
      ),

      // FAB
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
    );
  }
}