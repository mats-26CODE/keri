import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../core/config/app_constants.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../core/values/app_sizes.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/url_launcher_helper.dart';
import '../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../shared/widgets/bottom_sheets/app_bottom_sheet.dart';
import '../../../../../shared/widgets/buttons/app_button.dart';

class TermsAcceptanceModal {
  static Future<bool?> show(BuildContext context) {
    return AppBottomSheet.show<bool>(
      context: context,
      showDragHandle: true,
      showCloseButton: true,
      isDismissible: true,
      enableDrag: true,
      child: _TermsAcceptanceContent(
        onAccept: () {
          Navigator.of(context).pop(true);
        },
      ),
    );
  }
}

class _TermsAcceptanceContent extends StatelessWidget {
  final VoidCallback onAccept;

  const _TermsAcceptanceContent({required this.onAccept});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
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
            icon: HugeIcons.strokeRoundedAiUser,
            size: 40,
            color: isDarkMode ? AppColors.dark.icon : AppColors.light.icon,
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
          "We are excited to have you on board!",
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
                style: AppTextStyles.buttonTextStyle(
                  isDarkMode: isDarkMode,
                  color: isDarkMode
                      ? AppColors.dark.primaryColor
                      : AppColors.light.primaryColor,
                  fontSize: AppSizes.fontSizeMedium,
                ).copyWith(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    UrlLauncherHelper.openInAppBrowser(
                      url: AppConstants.termsOfServiceUrl,
                      context: context,
                    );
                  },
              ),
              const TextSpan(text: ' & '),
              TextSpan(
                text: 'Privacy Policy',
                style: AppTextStyles.buttonTextStyle(
                  isDarkMode: isDarkMode,
                  color: isDarkMode
                      ? AppColors.dark.primaryColor
                      : AppColors.light.primaryColor,
                  fontSize: AppSizes.fontSizeMedium,
                ).copyWith(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    UrlLauncherHelper.openInAppBrowser(
                      url: AppConstants.privacyPolicyUrl,
                      context: context,
                    );
                  },
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSizes.spacingXXLarge),

        // Accept Button
        AppButton(text: 'Accept & Continue', onPressed: onAccept),

        const SizedBox(height: AppSizes.spacingLarge),
      ],
    );
  }
}
