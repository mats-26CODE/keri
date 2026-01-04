import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keri/shared/widgets/animations/animations.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../animations/scale_animation_tap_wrapper.dart';

/// A reusable toggle pill component with customizable styling
class AppTogglePill extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;
  final Color? unselectedBackgroundColor;
  final Color? unselectedTextColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final double? textSize;
  final double? toggleWidth;
  final dynamic leadingIcon;
  final double? iconSize;
  final MainAxisAlignment? mainAxisAlignment;

  const AppTogglePill({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.padding,
    this.borderWidth,
    this.borderRadius,
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.unselectedBackgroundColor,
    this.unselectedTextColor,
    this.textSize,
    this.toggleWidth,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.leadingIcon,
    this.iconSize,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return ScaleAnimationTapWrapper(
      onTap: onTap,
      child: Container(
        width: toggleWidth,
        padding:
            padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSizes.spacingMedium,
              vertical: AppSizes.spacingMedium,
            ),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedBackgroundColor ??
                    (isDarkMode
                        ? AppColors.dark.primaryColor.withAlpha(50)
                        : AppColors.light.primaryColor.withAlpha(30))
              : unselectedBackgroundColor ??
                    (isDarkMode
                        ? AppColors.dark.darkSurfaceGrayColor
                        : AppColors.light.lightGrayColor),
          borderRadius:
              borderRadius ?? BorderRadius.circular(AppSizes.fullBorderRadius),
          border: Border.all(
            color: isSelected
                ? selectedBorderColor ??
                      (isDarkMode
                          ? AppColors.dark.primaryColor
                          : AppColors.light.primaryColor)
                : unselectedBorderColor ??
                      (isDarkMode
                          ? AppColors.dark.grayishBorderColor
                          : AppColors.light.grayishBorderColor),
            width: borderWidth ?? 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon is HugeIcon
                  ? leadingIcon
                  : leadingIcon is IconData
                  ? Icon(
                      leadingIcon as IconData,
                      size: iconSize ?? 24,
                      color: isSelected
                          ? selectedTextColor ??
                                (isDarkMode
                                    ? AppColors.dark.text
                                    : AppColors.light.text)
                          : unselectedTextColor ??
                                (isDarkMode
                                    ? AppColors.dark.text
                                    : AppColors.light.text),
                    )
                  : (leadingIcon is String)
                  ? Image.asset(
                      leadingIcon as String,
                      height: iconSize ?? 24,
                      width: iconSize ?? 24,
                      fit: BoxFit.contain,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(width: AppSizes.spacingSmall),
            ],
            FadeInText.subtitle(
              text: text,
              textAlign: TextAlign.center,
              fontSize: textSize ?? AppSizes.fontSizeMedium,
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              color: isSelected
                  ? selectedTextColor ??
                        (isDarkMode
                            ? AppColors.dark.text
                            : AppColors.light.text)
                  : unselectedTextColor ??
                        (isDarkMode
                            ? AppColors.dark.text
                            : AppColors.light.text),
            ),
          ],
        ),
      ),
    );
  }
}
