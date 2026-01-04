import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../providers/location_provider.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../core/values/app_sizes.dart';
import '../../../../../shared/widgets/buttons/app_button.dart';
import '../../../../../shared/widgets/buttons/app_icon_button.dart';
import '../../../../../shared/widgets/indicators/app_page_indicator.dart';
import '../../models/registration_data.dart';
import '../../providers/registration_provider.dart';
import '../../widgets/terms_acceptance_bottom_sheet.dart';
import 'steps/choose_role_step.dart';
import 'steps/personal_profile_step.dart';
import 'steps/business_profile_step.dart';
import 'steps/location_selection_step.dart';
import 'steps/otp_verification_step.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Reset registration state when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(registrationStepProvider.notifier).reset();
      ref.read(registrationProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _getSteps() {
    final registrationData = ref.watch(registrationProvider);
    final userRole = registrationData.userRole;

    if (userRole == null) {
      return [const ChooseRoleStep()];
    }

    if (userRole == UserRole.personal) {
      return [
        const ChooseRoleStep(),
        const PersonalProfileStep(),
        const OtpVerificationStep(),
      ];
    } else {
      return [
        const ChooseRoleStep(),
        const BusinessProfileStep(),
        const LocationSelectionStep(),
        const OtpVerificationStep(),
      ];
    }
  }

  String _getButtonText() {
    final currentStep = ref.read(registrationStepProvider);
    final registrationData = ref.read(registrationProvider);

    if (currentStep == 0) return 'Continue';

    // For location step (business only)
    if (registrationData.userRole == UserRole.business && currentStep == 2) {
      return 'Confirm Location';
    }

    return 'Next';
  }

  void _handleNext() async {
    final currentStep = ref.read(registrationStepProvider);
    final steps = _getSteps();
    final registrationData = ref.read(registrationProvider);

    // Validate current step
    if (currentStep == 0 && registrationData.userRole == null) {
      // Show error: Please select a role
      return;
    }

    // Show terms acceptance before profile setup
    if (currentStep == 0) {
      final accepted = await TermsAcceptanceBottomSheet.show(context);
      if (accepted != true) return;
    }

    // Save location data and validate for business users
    if (registrationData.userRole == UserRole.business && currentStep == 2) {
      // Get location state from provider
      final locationState = ref.read(locationProvider);

      if (locationState.selectedLocation == null ||
          locationState.locationName == null ||
          locationState.locationName!.isEmpty) {
        // Show error: Please select a location
        return;
      }

      // Save location data to registration
      ref
          .read(registrationProvider.notifier)
          .setLocation(
            latitude: locationState.selectedLocation!.latitude,
            longitude: locationState.selectedLocation!.longitude,
            locationName: locationState.locationName!,
          );
    }

    if (currentStep < steps.length - 1) {
      ref.read(registrationStepProvider.notifier).nextStep();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleBack() {
    final currentStep = ref.read(registrationStepProvider);
    if (currentStep > 0) {
      ref.read(registrationStepProvider.notifier).previousStep();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final currentStep = ref.watch(registrationStepProvider);
    final steps = _getSteps();

    return PopScope(
      canPop: currentStep == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // If we actually popped (only happens on step 0), reset state
          ref.read(registrationStepProvider.notifier).reset();
          ref.read(registrationProvider.notifier).reset();
        } else {
          // If we didn't pop (step > 0), go to previous step
          _handleBack();
        }
      },
      child: Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.dark.background
            : AppColors.light.background,
        body: SafeArea(
          child: Column(
            children: [
              // Header with back button and progress indicators
              Padding(
                padding: const EdgeInsets.all(AppSizes.screenPaddingX),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Back Button
                    AppIconButton(
                      icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowLeft02,
                        size: AppSizes.iconSizeLarge,
                      ),
                      onPressed: _handleBack,
                      isOutlined: true,
                      size: AppSizes.iconSizeLarge,
                      borderColor: Colors.transparent,
                      iconColor: isDarkMode
                          ? AppColors.dark.icon
                          : AppColors.light.icon,
                    ),
                    // Progress Indicators
                    AppPageIndicator(
                      totalSteps: steps.length,
                      currentStep: currentStep,
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),

              // Steps Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: steps,
                ),
              ),

              // Navigation Buttons (hide only for OTP step)
              if (currentStep != steps.length - 1)
                Padding(
                  padding: const EdgeInsets.all(AppSizes.screenPaddingX),
                  child: Row(
                    children: [
                      // Back Button (only show after first step)
                      if (currentStep > 0)
                        Expanded(
                          flex: 1,
                          child: AppButton(
                            text: 'Back',
                            onPressed: _handleBack,
                            isOutlined: true,
                            backgroundColor: isDarkMode
                                ? AppColors.dark.background
                                : AppColors.light.background,
                            textColor: isDarkMode
                                ? AppColors.dark.text
                                : AppColors.light.text,
                            borderColor: isDarkMode
                                ? AppColors.dark.grayishBorderColor
                                : AppColors.light.grayishBorderColor,
                          ),
                        ),
                      if (currentStep > 0)
                        const SizedBox(width: AppSizes.spacingMedium),
                      // Next/Continue Button
                      Expanded(
                        flex: 2,
                        child: AppButton(
                          text: _getButtonText(),
                          onPressed: _handleNext,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
