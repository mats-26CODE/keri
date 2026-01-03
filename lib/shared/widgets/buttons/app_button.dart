import 'package:flutter/material.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/utils/app_text_styles.dart';
import '../animations/scale_animation_tap_wrapper.dart';
import '../loading/loading_spinner.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool isExpanded;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final bool hasGradient;
  final double? fontSize;
  final double? iconSize;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isExpanded = true,
    this.isOutlined = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.hasGradient = true,
    this.fontSize,
    this.iconSize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color bg =
        backgroundColor ??
        (isOutlined
            ? Colors.transparent
            : isDarkMode
            ? AppColors.dark.primaryColor
            : AppColors.light.primaryColor);
    final Color border =
        borderColor ??
        (isOutlined
            ? (isDarkMode
                  ? AppColors.dark.primaryColor
                  : AppColors.light.primaryColor.withAlpha(100))
            : (isDarkMode
                  ? AppColors.dark.grayishBorderColor.withAlpha(50)
                  : AppColors.light.grayishBorderColor.withAlpha(100)));
    final Color txtColor =
        textColor ??
        (isOutlined
            ? (isDarkMode ? AppColors.dark.text : AppColors.light.primaryColor)
            : (isDarkMode
                  ? AppColors.dark.darkSurfaceColor
                  : AppColors.light.lightGrayColor));

    return SizedBox(
      width: isExpanded ? double.infinity : null,
      height: AppSizes.buttonHeight,
      child: ScaleAnimationTapWrapper(
        onTap: isLoading ? null : onPressed,
        child: Container(
          width: isExpanded ? double.infinity : null,
          height: AppSizes.buttonHeight,
          decoration: BoxDecoration(
            gradient: hasGradient && !isOutlined
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      isDarkMode
                          ? AppColors.dark.primaryColor
                          : AppColors.light.primaryColor,
                      isDarkMode
                          ? AppColors.dark.primaryColor
                          : AppColors.light.primaryColor,
                    ],
                  )
                : null,
            color: hasGradient ? null : (isOutlined ? Colors.transparent : bg),
            borderRadius: BorderRadius.circular(AppSizes.fullBorderRadius),
            border: Border.all(color: border, width: 2),
            boxShadow: hasGradient && !isOutlined
                ? [
                    BoxShadow(
                      color: isDarkMode
                          ? AppColors.dark.primaryColor.withAlpha(50)
                          : AppColors.light.primarishShadowColor,
                      blurRadius: 16,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: null, // Let ScaleAnimationWrapper handle the tap
              borderRadius: BorderRadius.circular(AppSizes.fullBorderRadius),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacingRegular,
                ),
                child: isLoading
                    ? const LoadingSpinner()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) ...[
                            Container(
                              width: iconSize ?? 24,
                              height: iconSize ?? 24,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: Center(child: icon!),
                            ),
                            const SizedBox(width: 5),
                          ],
                          SizedBox(width: AppSizes.spacingSmall),
                          Text(
                            text,
                            style: AppTextStyles.buttonTextStyle(
                              isDarkMode: isDarkMode,
                              color: txtColor,
                              fontSize: fontSize,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
