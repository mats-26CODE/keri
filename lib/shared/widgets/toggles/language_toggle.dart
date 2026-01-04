import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../animations/fade_in_text.dart';
import '../animations/slide_fade_in_animation.dart';
import '../animations/scale_animation_tap_wrapper.dart';
import '../bottom_sheets/app_bottom_sheet.dart';
import '../pills/app_toggle_pill.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

class LanguageToggle extends ConsumerWidget {
  final double size;

  const LanguageToggle({super.key, this.size = AppSizes.iconSizeXLarge});

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
          const SizedBox(height: AppSizes.spacingMedium),

          // Icon
          Container(
            padding: const EdgeInsets.all(AppSizes.spacingLarge),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode
                  ? AppColors.dark.primaryColor.withAlpha(20)
                  : AppColors.light.primaryColor.withAlpha(20),
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedLanguageSquare,
              size: 40,
              color: isDarkMode ? AppColors.dark.icon : AppColors.light.icon,
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          // Title
          FadeInText.heading(
            text: "Change Language",
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeXLarge,
            duration: const Duration(milliseconds: 300),
            delay: const Duration(milliseconds: 100),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          ...AppLanguage.values.map((language) {
            final isSelected = currentLanguage == language;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.spacingSmall),
              child: SlideFadeInAnimation(
                duration: const Duration(milliseconds: 300),
                delay: const Duration(milliseconds: 100),
                beginOffset: const Offset(0, 0.1),
                child: AppTogglePill(
                  text: language.name,
                  isSelected: isSelected,
                  onTap: () {
                    ref.read(languageProvider.notifier).setLanguage(language);
                  },
                  padding: const EdgeInsets.all(AppSizes.spacingLarge),
                  mainAxisAlignment: MainAxisAlignment.start,
                  borderWidth: 2,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  leadingIcon: isSelected
                      ? const HugeIcon(
                          icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                          size: AppSizes.iconSizeRegular,
                        )
                      : null,
                  textSize: AppSizes.fontSizeLarge,
                ),
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
