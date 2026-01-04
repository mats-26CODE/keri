import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../animations/fade_in_text.dart';
import '../animations/scale_animation_tap_wrapper.dart';
import '../bottom_sheets/app_bottom_sheet.dart';
import '../pills/app_toggle_pill.dart';

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
                    ? HugeIcons.strokeRoundedCheckmarkCircle02
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

    // Get flag image based on language
    final flagImage = language == AppLanguage.english
        ? AppAssets.englishFlag
        : AppAssets.tzFlag;

    return ScaleAnimationTapWrapper(
      onTap: () => _showLanguageSelector(context, ref),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isDarkMode
                ? AppColors.dark.grayishBorderColor
                : AppColors.light.grayishBorderColor,
            width: 1,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            flagImage,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
