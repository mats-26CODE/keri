import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../../core/values/app_colors.dart';
import '../../../../../../core/values/app_sizes.dart';
import '../../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../../shared/widgets/animations/slide_fade_in_animation.dart';
import '../../../../../../shared/widgets/pills/app_toggle_pill.dart';
import '../../../models/registration_data.dart';
import '../../../providers/registration_provider.dart';

class ChooseRoleStep extends ConsumerWidget {
  const ChooseRoleStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final registrationData = ref.watch(registrationProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingX),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          SlideFadeInAnimation(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 100),
            beginOffset: const Offset(0, 0.3),
            child: FadeInText.heading(
              text: 'How will you use the app',
              textAlign: TextAlign.center,
              fontSize: AppSizes.fontSizeXXLarge,
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Subtitle
          FadeInText.body(
            text: 'Choose the option that best describes you.',
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeLarge,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 300),
          ),

          const SizedBox(height: AppSizes.spacingXXLarge),

          // Personal Use Option
          SlideFadeInAnimation(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 400),
            beginOffset: const Offset(-0.3, 0),
            child: AppTogglePill(
              text: UserRole.personal.description,
              isSelected: registrationData.userRole == UserRole.personal,
              onTap: () {
                ref
                    .read(registrationProvider.notifier)
                    .setUserRole(UserRole.personal);
              },
              padding: const EdgeInsets.all(AppSizes.spacingLarge),
              borderWidth: 2,
              selectedBackgroundColor: isDarkMode
                  ? AppColors.dark.primaryColor.withAlpha(50)
                  : AppColors.light.primaryColor.withAlpha(30),
              unselectedBackgroundColor: isDarkMode
                  ? AppColors.dark.darkSurfaceGrayColor
                  : AppColors.light.lightGrayColor,
              selectedBorderColor: isDarkMode
                  ? AppColors.dark.primaryColor
                  : AppColors.light.primaryColor,
              unselectedBorderColor: isDarkMode
                  ? AppColors.dark.grayishBorderColor
                  : AppColors.light.grayishBorderColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              leadingIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                size: 32,
              ),
              textSize: AppSizes.fontSizeLarge,
            ),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          // Business Use Option
          SlideFadeInAnimation(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 500),
            beginOffset: const Offset(0.3, 0),
            child: AppTogglePill(
              text: UserRole.business.description,
              isSelected: registrationData.userRole == UserRole.business,
              onTap: () {
                ref
                    .read(registrationProvider.notifier)
                    .setUserRole(UserRole.business);
              },
              padding: const EdgeInsets.all(AppSizes.spacingLarge),
              borderWidth: 2,
              selectedBackgroundColor: isDarkMode
                  ? AppColors.dark.primaryColor.withAlpha(50)
                  : AppColors.light.primaryColor.withAlpha(30),
              unselectedBackgroundColor: isDarkMode
                  ? AppColors.dark.darkSurfaceGrayColor
                  : AppColors.light.lightGrayColor,
              selectedBorderColor: isDarkMode
                  ? AppColors.dark.primaryColor
                  : AppColors.light.primaryColor,
              unselectedBorderColor: isDarkMode
                  ? AppColors.dark.grayishBorderColor
                  : AppColors.light.grayishBorderColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              leadingIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedStore01,
                size: 32,
              ),
              textSize: AppSizes.fontSizeLarge,
            ),
          ),
        ],
      ),
    );
  }
}

