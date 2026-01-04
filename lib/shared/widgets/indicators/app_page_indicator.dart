import 'package:flutter/material.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';

/// Reusable page indicator widget for showing progress in multi-step flows
class AppPageIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final bool isDarkMode;
  final double? activeWidth;
  final double? inactiveWidth;
  final double? height;
  final Color? activeColor;
  final Color? inactiveColor;
  final double spacing;
  final BorderRadius? borderRadius;

  const AppPageIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.isDarkMode,
    this.activeWidth,
    this.inactiveWidth,
    this.height,
    this.activeColor,
    this.inactiveColor,
    this.spacing = AppSizes.spacingSmall / 4,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final defaultActiveWidth = activeWidth ?? AppSizes.indicatorActiveWidth;
    final defaultInactiveWidth =
        inactiveWidth ?? AppSizes.indicatorInactiveWidth;
    final defaultHeight = height ?? AppSizes.indicatorHeight;
    final defaultActiveColor = activeColor ?? AppColors.light.primaryColor;
    final defaultInactiveColor =
        inactiveColor ??
        (isDarkMode
            ? AppColors.dark.darkSurfaceGrayColor
            : AppColors.light.grayishBorderColor);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalSteps,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: spacing),
          width: index == currentStep
              ? defaultActiveWidth
              : defaultInactiveWidth,
          height: defaultHeight,
          decoration: BoxDecoration(
            borderRadius:
                borderRadius ?? BorderRadius.circular(defaultHeight / 2),
            color: index == currentStep
                ? defaultActiveColor
                : defaultInactiveColor,
          ),
        ),
      ),
    );
  }
}

/// Simple page indicator dot (circular)
class AppPageIndicatorDot extends StatelessWidget {
  final bool isActive;
  final bool isDarkMode;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const AppPageIndicatorDot({
    super.key,
    required this.isActive,
    required this.isDarkMode,
    this.size = 8,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultActiveColor = activeColor ?? AppColors.light.primaryColor;
    final defaultInactiveColor =
        inactiveColor ??
        (isDarkMode
            ? AppColors.dark.darkSurfaceGrayColor
            : AppColors.light.grayishBorderColor);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? defaultActiveColor : defaultInactiveColor,
      ),
    );
  }
}

/// Row of page indicator dots with spacing
class AppPageIndicatorRow extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final bool isDarkMode;
  final double dotSize;
  final double spacing;
  final Color? activeColor;
  final Color? inactiveColor;

  const AppPageIndicatorRow({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.isDarkMode,
    this.dotSize = 8,
    this.spacing = AppSizes.spacingSmall / 4,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalSteps,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: AppPageIndicatorDot(
            isActive: index == currentStep,
            isDarkMode: isDarkMode,
            size: dotSize,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
          ),
        ),
      ),
    );
  }
}
