import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../../core/values/app_colors.dart';
import '../../../../../../core/values/app_sizes.dart';
import '../../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../../shared/widgets/inputs/app_input.dart';
import '../../../providers/registration_provider.dart';

class PersonalProfileStep extends ConsumerStatefulWidget {
  const PersonalProfileStep({super.key});

  @override
  ConsumerState<PersonalProfileStep> createState() =>
      _PersonalProfileStepState();
}

class _PersonalProfileStepState extends ConsumerState<PersonalProfileStep> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final registrationData = ref.read(registrationProvider);
    _phoneController.text = registrationData.phoneNumber ?? '';
    _usernameController.text = registrationData.username ?? '';
    _emailController.text = registrationData.email ?? '';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateData() {
    ref
        .read(registrationProvider.notifier)
        .setPersonalDetails(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
        );
    ref
        .read(registrationProvider.notifier)
        .setPhoneNumber(_phoneController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingX),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSizes.spacingLarge),

          // Title
          FadeInText.heading(
            text: 'Setup Your Personal Profile',
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeXLarge,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 100),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Subtitle
          FadeInText.body(
            text: "We'll send OTP codes to verify your phone number",
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeMedium,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 200),
          ),

          const SizedBox(height: AppSizes.spacingXXLarge),

          // Profile Picture Placeholder
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? AppColors.dark.darkSurfaceGrayColor
                    : AppColors.light.lightGrayColor,
              ),
              child: Stack(
                children: [
                  Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedUserCircle,
                      size: 80,
                      color: isDarkMode
                          ? AppColors.dark.mediumGrayColor
                          : AppColors.light.mediumGrayColor,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDarkMode
                            ? AppColors.dark.primaryColor
                            : AppColors.light.primaryColor,
                      ),
                      child: const HugeIcon(
                        icon: HugeIcons.strokeRoundedPencilEdit02,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingXXLarge),

          // Phone Number Input
          AppInput(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            labelText: 'Phone Number',
            hintText: 'Enter phone number',
            maxLength: 10,
            onChanged: (_) => _updateData(),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '+255',
                style: TextStyle(
                  fontSize: AppSizes.fontSizeMedium,
                  color: isDarkMode
                      ? AppColors.dark.text
                      : AppColors.light.text,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          // Username Input
          AppInput(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            labelText: 'Username',
            hintText: 'Enter username',
            onChanged: (_) => _updateData(),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(icon: HugeIcons.strokeRoundedUser, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          // Email Input
          AppInput(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: 'Email Address',
            hintText: 'Enter email address',
            onChanged: (_) => _updateData(),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(icon: HugeIcons.strokeRoundedMail01, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
