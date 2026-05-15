import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  AppColors._();

  static const Color bg = Colors.black;
  static const Color surface = Color(0xFF18181C);
  static const Color surfaceAlt = Color(0xFF1E1E1E);
  static const Color surfaceHigh = Color(0xFF18181C);

  static const Color border = Color(0x12FFFFFF);
  static const Color borderStrong = Color(0x20FFFFFF);
  static const Color borderFocus = Color(0x40FFFFFF);

  static const Color primary = Color(0xFF4DD9C0);
  static const Color primaryLight = Color(0xFF6EE5CF);
  static const Color primaryDark = Color(0xFF33BFA8);
  static const Color primaryDim = Color(0xFF1B3D45);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF7A7A7A);
  static const Color textMuted = Color(0xFF3A3A3A);
  static const Color textDisabled = Color(0xFF2A2A2A);

  static const Color success = Color(0xFF4CAF76);
  static const Color successLight = Color(0xFF6DC48F);
  static const Color successDim = Color(0x334CAF76);

  static const Color error = Color(0xFFE05C5C);
  static const Color errorDim = Color(0x33E05C5C);

  static const Color warning = Color(0xFFFFD060);
  static const Color warningDim = Color(0x33FFD060);

  static const Color blue = Color(0xFF48A4E5);
  static const Color blueDim = Color(0x266B82D4);

  static const Color purple = Color(0xFF9B7FCC);
  static const Color purpleDim = Color(0x269B7FCC);

  static const Color orange = Color(0xFFFF8C42);
  static const Color orangeDim = Color(0x26FF8C42);

  static const Color pink = Color(0xFFFF7AAF);
  static const Color pinkDim = Color(0x26FF7AAF);

  static const Color yellow = Color(0xFFFFD060);
  static const Color yellowDim = Color(0x26FFD060);
}

class AppRadius {
  AppRadius._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 28;
  static const double full = 999;

  static BorderRadius get circularSm => BorderRadius.circular(sm);
  static BorderRadius get circularMd => BorderRadius.circular(md);
  static BorderRadius get circularLg => BorderRadius.circular(lg);
  static BorderRadius get circularXl => BorderRadius.circular(xl);
  static BorderRadius get circularFull => BorderRadius.circular(full);
}

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> modal = [
    BoxShadow(color: Color(0x66000000), blurRadius: 32, offset: Offset(0, -4)),
  ];

  static const List<BoxShadow> button = [
    BoxShadow(color: Color(0x404DD9C0), blurRadius: 16, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> float = [
    BoxShadow(color: Color(0x55000000), blurRadius: 24, offset: Offset(0, 8)),
  ];
}

class AppTheme {
  AppTheme._();

  static const Color bg = AppColors.bg;
  static const Color surface = AppColors.surface;
  static const Color surfaceAlt = AppColors.surfaceAlt;
  static const Color border = AppColors.border;
  static const Color borderStrong = AppColors.borderStrong;
  static const Color primary = AppColors.primary;
  static const Color primaryDim = AppColors.primaryDim;
  static const Color greenColor = Color(0xFF20B76F);
  static const Color greenColorLight = Color(0xFF062315);
  static const Color white = AppColors.white;
  static const Color textSecondary = AppColors.textSecondary;
  static const Color textMuted = AppColors.textMuted;
  static const Color success = AppColors.success;
  static const Color successDim = AppColors.successDim;
  static const Color blue = AppColors.blue;
  static const Color blueDim = AppColors.blueDim;
  static const Color purple = AppColors.purple;
  static const Color orange = AppColors.orange;
  static const Color pink = AppColors.pink;
  static const Color yellow = AppColors.yellow;

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    fontFamily: 'Mulish',
    scaffoldBackgroundColor: AppColors.bg,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surface,
      primary: AppColors.primary,
      onPrimary: AppColors.bg,
      secondary: AppColors.blue,
      onSecondary: AppColors.white,
      error: AppColors.error,
      onError: AppColors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 56,
        fontWeight: FontWeight.w900,
        color: AppColors.white,
        letterSpacing: -2,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 48,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
        letterSpacing: -1.5,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        letterSpacing: -0.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        letterSpacing: 0.1,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        letterSpacing: 0.2,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        letterSpacing: 0.4,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.bg,
        elevation: 0,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontFamily: 'Mulish',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontFamily: 'Mulish',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: const TextStyle(
          fontFamily: 'Mulish',
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      hintStyle: const TextStyle(
        fontFamily: 'Mulish',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
      ),
      labelStyle: const TextStyle(
        fontFamily: 'Mulish',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      elevation: 0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surfaceHigh,
      contentTextStyle: const TextStyle(
        fontFamily: 'Mulish',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceAlt,
      labelStyle: const TextStyle(
        fontFamily: 'Mulish',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: BorderSide.none,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.surfaceAlt,
      linearMinHeight: 4,
    ),
    iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 24),
  );
}
