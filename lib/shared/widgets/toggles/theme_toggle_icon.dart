import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/values/app_colors.dart';
import '../animations/scale_animation_tap_wrapper.dart';

class ThemeToggleIcon extends ConsumerWidget {
  final double size;

  const ThemeToggleIcon({super.key, this.size = 40});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return ScaleAnimationTapWrapper(
      onTap: () {
        ref.read(themeModeProvider.notifier).toggleTheme();
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColors.dark.darkSurfaceComplimentColor.withAlpha(180)
              : AppColors.light.lightGrayColor.withAlpha(180),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: isDarkMode
              ? AppColors.dark.warningColor
              : AppColors.light.icon,
          size: size * 0.5,
        ),
      ),
    );
  }
}
