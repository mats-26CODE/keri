import 'package:flutter/material.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../core/values/app_sizes.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../shared/widgets/buttons/app_button.dart';

class TermsAcceptanceBottomSheet extends StatelessWidget {
  final VoidCallback onAccept;

  const TermsAcceptanceBottomSheet({super.key, required this.onAccept});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TermsAcceptanceBottomSheet(
        onAccept: () {
          Navigator.of(context).pop(true);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.dark.background
            : AppColors.light.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusXLarge),
        ),
      ),
      padding: const EdgeInsets.all(AppSizes.screenPaddingX),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.dark.mediumGrayColor
                  : AppColors.light.mediumGrayColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: AppSizes.spacingXLarge),

          // Icon
          Container(
            padding: const EdgeInsets.all(AppSizes.spacingLarge),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode
                  ? AppColors.dark.primaryColor.withAlpha(30)
                  : AppColors.light.primaryColor.withAlpha(30),
            ),
            child: Icon(
              Icons.person_outline,
              size: 48,
              color: isDarkMode
                  ? AppColors.dark.primaryColor
                  : AppColors.light.primaryColor,
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          // Title
          FadeInText.heading(
            text: "Let's Get You Set Up",
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeXLarge,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 100),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          // Description
          Text(
            "It looks like you don't have an account yet.",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyStyle(
              isDarkMode: isDarkMode,
              fontSize: AppSizes.fontSizeMedium,
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Terms Text
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.bodyStyle(
                isDarkMode: isDarkMode,
                fontSize: AppSizes.fontSizeMedium,
              ),
              children: [
                const TextSpan(
                  text:
                      'By Registering you confirm you\'ve read and accepted our ',
                ),
                TextSpan(
                  text: 'Terms & Conditions',
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.dark.primaryColor
                        : AppColors.light.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' & '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.dark.primaryColor
                        : AppColors.light.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.spacingXXLarge),

          // Accept Button
          AppButton(text: 'Accept & Continue', onPressed: onAccept),

          const SizedBox(height: AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
