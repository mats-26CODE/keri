import 'package:flutter/material.dart';
import '../values/app_colors.dart';
import '../values/app_sizes.dart';

/// Text styles for the Keri app
class AppTextStyles {
  // Heading style
  static TextStyle headingStyle({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  }) => TextStyle(
    fontFamily: 'Figtree',
    fontSize: fontSize ?? AppSizes.fontSizeXLarge,
    fontWeight: FontWeight.bold,
    color: color ?? (isDarkMode ? AppColors.dark.text : AppColors.light.text),
  );

  // Body style
  static TextStyle bodyStyle({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  }) => TextStyle(
    fontFamily: 'Figtree',
    fontSize: fontSize ?? AppSizes.fontSizeRegular,
    color: color ?? (isDarkMode ? AppColors.dark.text : AppColors.light.text),
  );

  // Title styles
  static TextStyle titleStyle({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  }) => TextStyle(
    fontFamily: 'Figtree',
    fontSize: fontSize ?? AppSizes.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: color ?? (isDarkMode ? AppColors.dark.text : AppColors.light.text),
  );

  // Subtitle style
  static TextStyle subtitleStyle({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  }) => TextStyle(
    fontFamily: 'Figtree',
    fontSize: fontSize ?? AppSizes.fontSizeLarge,
    fontWeight: FontWeight.w500,
    color: color ?? (isDarkMode ? AppColors.dark.text : AppColors.light.text),
  );

  // Button text style
  static TextStyle buttonTextStyle({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  }) => TextStyle(
    fontFamily: 'Figtree',
    fontSize: fontSize ?? AppSizes.fontSizeMedium,
    fontWeight: FontWeight.w600,
    color: color ?? (isDarkMode ? AppColors.dark.text : AppColors.light.text),
  );

  // Input text style
  static TextStyle inputTextStyle({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  }) => TextStyle(
    fontFamily: 'Figtree',
    fontSize: fontSize ?? AppSizes.fontSizeRegular,
    color: color ?? (isDarkMode ? AppColors.dark.text : AppColors.light.text),
  );

  // Label text style
  static TextStyle labelTextStyle({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  }) => TextStyle(
    fontFamily: 'Figtree',
    fontSize: fontSize ?? AppSizes.fontSizeRegular,
    fontWeight: FontWeight.w500,
    color: color ?? (isDarkMode ? AppColors.dark.text : AppColors.light.text),
  );

  // Link text style
  static TextStyle linkTextStyle({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  }) => TextStyle(
    fontFamily: 'Figtree',
    fontSize: fontSize ?? AppSizes.fontSizeRegular,
    color:
        color ??
        (isDarkMode ? AppColors.dark.linkColor : AppColors.light.linkColor),
    decoration: TextDecoration.underline,
  );

  // Caption text style
  static TextStyle captionTextStyle({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  }) => TextStyle(
    fontFamily: 'Figtree',
    fontSize: fontSize ?? AppSizes.fontSizeSmall,
    color: color ?? (isDarkMode ? AppColors.dark.text : AppColors.light.text),
  );
}
