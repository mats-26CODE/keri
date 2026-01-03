import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/utils/app_text_styles.dart';
import '../animations/slide_fade_in_animation.dart';

/// A reusable mascot widget that displays Lottie animations
/// with optional slide-in animation
class AppMascot extends StatelessWidget {
  /// Path to the Lottie animation file (e.g., 'assets/lottie/delivery.json')
  final String? lottiePath;

  /// Size of the mascot container
  final double size;

  /// Whether to apply slide-in animation
  final bool enableSlideAnimation;

  /// Duration of the slide animation
  final Duration slideDuration;

  /// Delay before starting the slide animation
  final Duration slideDelay;

  /// Offset for the slide animation (default: from right)
  final Offset slideOffset;

  /// Animation curve
  final Curve slideCurve;

  /// Placeholder text when no Lottie file is provided
  final String? placeholderText;

  /// Whether the Lottie animation should repeat
  final bool repeat;

  /// Whether the Lottie animation should auto-play
  final bool animate;

  const AppMascot({
    super.key,
    this.lottiePath,
    this.size = 200,
    this.enableSlideAnimation = true,
    this.slideDuration = const Duration(milliseconds: 500),
    this.slideDelay = const Duration(milliseconds: 100),
    this.slideOffset = const Offset(0.8, 0), // Slide from right by default
    this.slideCurve = Curves.easeOut,
    this.placeholderText,
    this.repeat = true,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final mascotContainer = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDarkMode
            ? AppColors.dark.darkSurfaceGrayColor
            : AppColors.light.lightGrayColor,
      ),
      child: lottiePath != null
          ? ClipOval(
              child: Lottie.asset(
                lottiePath!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                repeat: repeat,
                animate: animate,
              ),
            )
          : Center(
              child: Text(
                placeholderText ?? 'Mascot Artwork\nwill display here',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyStyle(
                  isDarkMode: isDarkMode,
                  color: isDarkMode
                      ? AppColors.dark.mediumGrayColor
                      : AppColors.light.mediumGrayColor,
                  fontSize: AppSizes.fontSizeSmall,
                ),
              ),
            ),
    );

    // Apply slide animation if enabled
    if (enableSlideAnimation) {
      return SlideFadeInAnimation(
        duration: slideDuration,
        delay: slideDelay,
        beginOffset: slideOffset,
        curve: slideCurve,
        child: mascotContainer,
      );
    }

    // Return without animation
    return mascotContainer;
  }
}

