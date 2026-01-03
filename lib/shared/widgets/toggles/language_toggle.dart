import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:keri/shared/widgets/animations/animations.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/utils/app_text_styles.dart';
import '../bottom_sheets/app_bottom_sheet.dart';
import '../pills/app_toggle_pill.dart';
import 'package:hugeicons/hugeicons.dart';

class LanguageToggle extends ConsumerWidget {
  final double size;

  const LanguageToggle({super.key, this.size = 40});

  void _showLanguageSelector(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final currentLanguage = ref.read(languageProvider);

    AppBottomSheet.show(
      context: context,
      showDragHandle: true,
      showCloseButton: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeInText.heading(
            text: 'Select Language',
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeLarge,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          ),
          const SizedBox(height: AppSizes.spacingLarge),
          ...AppLanguage.values.map((language) {
            final isSelected = currentLanguage == language;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.spacingSmall),
              child: AppTogglePill(
                text: language.name,
                isSelected: isSelected,
                onTap: () {
                  ref.read(languageProvider.notifier).setLanguage(language);
                  Navigator.pop(context);
                },
                selectedBackgroundColor: isDarkMode
                    ? AppColors.dark.primaryColor.withAlpha(50)
                    : AppColors.light.primaryColor.withAlpha(10),
                unselectedBackgroundColor: isDarkMode
                    ? AppColors.dark.darkSurfaceGrayColor
                    : AppColors.light.lightGrayColor,
                selectedBorderColor: isDarkMode
                    ? AppColors.dark.primaryColor
                    : AppColors.light.primaryColor,
                selectedTextColor: isDarkMode
                    ? AppColors.dark.text
                    : AppColors.light.text,
                borderWidth: 2,
                leadingIcon: isSelected
                    ? HugeIcon(
                        icon: HugeIconsStrokeRounded.checkmarkCircle02,
                        strokeWidth: 2.0,
                        size: AppSizes.iconSizeMedium,
                      )
                    : null,
                borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            );
          }),
          const SizedBox(height: AppSizes.spacingMedium),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ScaleAnimationTapWrapper(
      onTap: () => _showLanguageSelector(context, ref),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColors.dark.darkSurfaceComplimentColor.withAlpha(180)
              : AppColors.light.lightGrayColor.withAlpha(180),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            language.code.toUpperCase(),
            style: AppTextStyles.buttonTextStyle(
              isDarkMode: isDarkMode,
              color: isDarkMode ? AppColors.dark.icon : AppColors.light.icon,
              fontSize: size * 0.35,
            ),
          ),
        ),
      ),
    );
  }
}
