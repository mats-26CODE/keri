import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../values/app_colors.dart';
import '../values/app_sizes.dart';

/// App theme definitions using AppColors
class AppTheme {
  /// Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Primary colors
      primaryColor: AppColors.light.primaryColor,
      scaffoldBackgroundColor: AppColors.light.background,

      // Color scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.light.primaryColor,
        secondary: AppColors.light.primaryDeepColor,
        tertiary: AppColors.light.primaryColor,
        surface: AppColors.light.card,
        error: AppColors.light.errorColor,
        onPrimary: AppColors.light.pureWhiteColor,
        onSecondary: AppColors.light.pureWhiteColor,
        onSurface: AppColors.light.text,
        onError: AppColors.light.pureWhiteColor,
        outline: AppColors.light.grayishBorderColor,
      ),

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.light.background,
        foregroundColor: AppColors.light.text,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: AppColors.light.icon),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.light.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),

      // Icon theme
      iconTheme: IconThemeData(color: AppColors.light.icon, size: 24),

      // Text theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeXXLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.light.text,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeXLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.light.text,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: AppColors.light.text,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeLarge,
          fontWeight: FontWeight.w500,
          color: AppColors.light.text,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeRegular,
          color: AppColors.light.text,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeMedium,
          color: AppColors.light.text,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeMedium,
          fontWeight: FontWeight.w600,
          color: AppColors.light.text,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.light.inputColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(color: AppColors.light.grayishBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(color: AppColors.light.grayishBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(color: AppColors.light.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(color: AppColors.light.errorColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(color: AppColors.light.errorColor, width: 2),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          color: AppColors.light.placeholderColor,
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.light.card,
        selectedItemColor: AppColors.light.tabIconSelected,
        unselectedItemColor: AppColors.light.tabIconDefault,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: AppColors.light.grayishBorderColor,
        thickness: 1,
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.light.pureWhiteColor;
          }
          return AppColors.light.primaryColor;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.light.successColor;
          }
          return AppColors.light.grayishBorderColor;
        }),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.light.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.light.sheetColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusLarge),
          ),
        ),
      ),

      // Font family
      fontFamily: 'Inter',
    );
  }

  /// Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Primary colors
      primaryColor: AppColors.dark.primaryColor,
      scaffoldBackgroundColor: AppColors.dark.background,

      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: AppColors.dark.primaryColor,
        secondary: AppColors.dark.primaryDeepColor,
        tertiary: AppColors.dark.primaryColor,
        surface: AppColors.dark.card,
        error: AppColors.dark.errorColor,
        onPrimary: AppColors.dark.pureWhiteColor,
        onSecondary: AppColors.dark.pureWhiteColor,
        onSurface: AppColors.dark.text,
        onError: AppColors.dark.pureWhiteColor,
        outline: AppColors.dark.grayishBorderColor,
      ),

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.dark.background,
        foregroundColor: AppColors.dark.text,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: AppColors.dark.icon),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.dark.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),

      // Icon theme
      iconTheme: IconThemeData(color: AppColors.dark.icon, size: 24),

      // Text theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeXXLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.dark.text,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeXLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.dark.text,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: AppColors.dark.text,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeLarge,
          fontWeight: FontWeight.w500,
          color: AppColors.dark.text,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeRegular,
          color: AppColors.dark.text,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeMedium,
          color: AppColors.dark.text,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.fontSizeMedium,
          fontWeight: FontWeight.w600,
          color: AppColors.dark.text,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.dark.inputColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(color: AppColors.dark.grayishBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(color: AppColors.dark.grayishBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(color: AppColors.dark.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(
            color: AppColors.dark.errorFadeColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide(color: AppColors.dark.errorColor, width: 2),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          color: AppColors.dark.placeholderColor,
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.dark.card,
        selectedItemColor: AppColors.dark.tabIconSelected,
        unselectedItemColor: AppColors.dark.tabIconDefault,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: AppColors.dark.grayishBorderColor,
        thickness: 1,
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.dark.pureWhiteColor;
          }
          return AppColors.dark.primaryColor;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.dark.successColor;
          }
          return AppColors.dark.grayishBorderColor;
        }),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.dark.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.dark.sheetColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusLarge),
          ),
        ),
      ),

      // Font family
      fontFamily: 'Inter',
    );
  }
}
