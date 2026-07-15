import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static TextTheme _buildTextTheme(TextTheme base) {
    return GoogleFonts.balooThambi2TextTheme(base).copyWith(
      displayLarge: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s57,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      displayMedium: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s45,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      displaySmall: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s36,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      headlineLarge: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s32,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineSmall: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s16,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      titleSmall: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      bodyLarge: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      bodySmall: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s12,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
      ),
      labelLarge: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      labelMedium: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      labelSmall: GoogleFonts.balooThambi2(
        fontSize: FontSizeManager.s11,
        fontWeight: FontWeight.w500,
        color: AppColors.textHint,
      ),
    );
  }

  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _buildTextTheme(ThemeData.light().textTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      foregroundColor: AppColors.textPrimary,
      centerTitle: false,
      scrolledUnderElevation: 0.0,
    ),

    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.textWhite,
      secondary: AppColors.primaryLight,
      onSecondary: AppColors.textWhite,
      error: AppColors.error,
      onError: AppColors.textWhite,
      surface: AppColors.grey1,
      onSurface: AppColors.textPrimary,
    ),

    dividerColor: AppColors.divider,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.background.withValues(alpha: 0.12),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p14,
      ),
      hintStyle: const TextStyle(
        color: AppColors.hintText,
        fontSize: FontSizeManager.s16,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: AppColors.iconInactive,
      suffixIconColor: AppColors.iconInactive,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.borderRadiusInput),
        borderSide: const BorderSide(
          color: AppColors.borderDefault,
          width: AppSize.borderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.borderRadiusInput),
        borderSide: const BorderSide(
          color: AppColors.borderDefault,
          width: AppSize.borderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.borderRadiusInput),
        borderSide: const BorderSide(
          color: AppColors.borderFocused,
          width: AppSize.focusedBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.borderRadiusInput),
        borderSide: const BorderSide(
          color: AppColors.borderError,
          width: AppSize.borderWidth,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.borderRadiusInput),
        borderSide: const BorderSide(
          color: AppColors.borderError,
          width: AppSize.focusedBorderWidth,
        ),
      ),
      errorStyle: const TextStyle(
        color: AppColors.borderError,
        fontSize: FontSizeManager.s12,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        disabledBackgroundColor: AppColors.grey700,
        disabledForegroundColor: AppColors.textWhite,
        minimumSize: const Size(double.infinity, AppSize.s50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusButton),
        ),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      ),
    ),
  );
}
