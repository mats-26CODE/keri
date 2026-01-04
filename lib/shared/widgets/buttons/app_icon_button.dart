import 'package:flutter/material.dart';
import '../../../core/values/app_colors.dart';
import '../animations/scale_animation_tap_wrapper.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final bool isFilled;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final double size;
  final bool isOutlined;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isFilled = true,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.isOutlined = false,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color icColor =
        iconColor ?? (isFilled ? Colors.white : AppColors.light.primaryColor);

    // Determine border color
    final Color effectiveBorderColor =
        borderColor ??
        (isOutlined && borderColor != null
            ? borderColor!
            : isFilled
            ? (isDarkMode
                  ? AppColors.dark.darkBorderColor
                  : AppColors.light.primaryColor)
            : (isDarkMode
                  ? AppColors.dark.darkBorderColor
                  : AppColors.light.grayishBorderColor));

    return ScaleAnimationTapWrapper(
      onTap: onPressed,
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: const CircleBorder(),
        child: InkWell(
          borderRadius: BorderRadius.circular(size / 2),
          customBorder: const CircleBorder(),
          onTap: null,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient:
                  backgroundColor == null && isFilled && isOutlined == false
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        isDarkMode
                            ? AppColors.dark.darkSurfaceComplimentColor
                            : AppColors.light.primaryColor,
                        isDarkMode
                            ? AppColors.dark.darkSurfaceComplimentColor
                            : AppColors.light.primaryColor,
                      ],
                    )
                  : null,
              color: isOutlined
                  ? Colors.transparent
                  : isFilled && backgroundColor == null
                  ? null
                  : isFilled && backgroundColor != null
                  ? backgroundColor
                  : Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: effectiveBorderColor, width: 1),
              boxShadow: isFilled && isOutlined == false
                  ? [
                      BoxShadow(
                        color: isDarkMode
                            ? AppColors.dark.primarishShadowColor
                            : AppColors.light.primarishShadowColor,
                        blurRadius: 8,
                        offset: const Offset(0, 0),
                        spreadRadius: 10,
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(color: icColor, size: size * 0.50),
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
