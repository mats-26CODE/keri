import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../../core/values/app_colors.dart';
import '../../../../../../core/values/app_sizes.dart';
import '../../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../../shared/widgets/animations/slide_fade_in_animation.dart';
import '../../../../../../shared/widgets/inputs/app_input.dart';
import '../../../../../../shared/widgets/buttons/app_button.dart';
import '../../../providers/registration_provider.dart';

class LocationSelectionStep extends ConsumerStatefulWidget {
  const LocationSelectionStep({super.key});

  @override
  ConsumerState<LocationSelectionStep> createState() =>
      _LocationSelectionStepState();
}

class _LocationSelectionStepState extends ConsumerState<LocationSelectionStep> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingX),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSizes.spacingMedium),

          // Title
          SlideFadeInAnimation(
            duration: const Duration(milliseconds: 300),
            delay: const Duration(milliseconds: 100),
            beginOffset: const Offset(0, 0.1),
            child: FadeInText.heading(
              text: "Great. Now let's set up your business location",
              fontSize: AppSizes.fontSizeTitleXXLarge,
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 100),
            ),
          ),

          const SizedBox(height: AppSizes.spacingXLarge),

          // Map Placeholder
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.dark.darkSurfaceGrayColor
                    : AppColors.light.lightGrayColor,
                borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              ),
              child: Stack(
                children: [
                  // Map would go here
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedMaps,
                          size: 80,
                          color: isDarkMode
                              ? AppColors.dark.mediumGrayColor
                              : AppColors.light.mediumGrayColor,
                        ),
                        const SizedBox(height: AppSizes.spacingMedium),
                        Text(
                          'Map View',
                          style: TextStyle(
                            fontSize: AppSizes.fontSizeMedium,
                            color: isDarkMode
                                ? AppColors.dark.mediumGrayColor
                                : AppColors.light.mediumGrayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Map Pin
                  Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedLocation01,
                      size: 48,
                      color: isDarkMode
                          ? AppColors.dark.primaryColor
                          : AppColors.light.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          // Search Input
          AppInput(
            controller: _searchController,
            keyboardType: TextInputType.text,
            hintText: 'e.g Mbezi Beach, Dar es Salaam',
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(icon: HugeIcons.strokeRoundedSearch01, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          // Helper Text
          SlideFadeInAnimation(
            duration: const Duration(milliseconds: 300),
            delay: const Duration(milliseconds: 150),
            beginOffset: const Offset(0, 0.1),
            child: FadeInText.body(
              text: '*You can drag your map to accurately locate the address',
              fontSize: AppSizes.fontSizeSmall,
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 150),
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          // Confirm Button
          AppButton(
            text: 'Confirm Location',
            onPressed: () {
              // Save location data
              ref
                  .read(registrationProvider.notifier)
                  .setLocation(
                    latitude: -6.8160837, // Example coordinates
                    longitude: 39.2803583,
                    locationName: _searchController.text.trim(),
                  );
              // Move to next step
              ref.read(registrationStepProvider.notifier).nextStep();
            },
          ),

          const SizedBox(height: AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
