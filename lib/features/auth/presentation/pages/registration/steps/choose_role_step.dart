import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
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
    final registrationData = ref.watch(registrationProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingX),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: AppSizes.spacingMedium),
          // Title
          SlideFadeInAnimation(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 100),
            beginOffset: const Offset(0, 0.3),
            child: FadeInText.heading(
              text: 'How will you use the app',
              fontSize: AppSizes.fontSizeTitleXXLarge,
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Subtitle
          FadeInText.body(
            text: 'Choose the option that best describes you.',
            fontSize: AppSizes.fontSizeLarge,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 300),
          ),

          const SizedBox(height: AppSizes.spacingLarge),

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
              mainAxisAlignment: MainAxisAlignment.start,
              borderWidth: 2,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              leadingIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedAiUser,
                size: AppSizes.iconSizeRegularPlus,
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
              mainAxisAlignment: MainAxisAlignment.start,
              borderWidth: 2,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              leadingIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedStore03,
                size: AppSizes.iconSizeRegularPlus,
              ),
              textSize: AppSizes.fontSizeLarge,
            ),
          ),
        ],
      ),
    );
  }
}
