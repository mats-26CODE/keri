import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../../core/values/app_colors.dart';
import '../../../../../../core/values/app_sizes.dart';
import '../../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../../shared/widgets/inputs/app_input.dart';
import '../../../providers/registration_provider.dart';

class BusinessProfileStep extends ConsumerStatefulWidget {
  const BusinessProfileStep({super.key});

  @override
  ConsumerState<BusinessProfileStep> createState() =>
      _BusinessProfileStepState();
}

class _BusinessProfileStepState extends ConsumerState<BusinessProfileStep> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _tinController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final registrationData = ref.read(registrationProvider);
    _phoneController.text = registrationData.phoneNumber ?? '';
    _emailController.text = registrationData.businessEmail ?? '';
    _businessNameController.text = registrationData.businessName ?? '';
    _categoryController.text = registrationData.businessCategory ?? '';
    _tinController.text = registrationData.tinNumber ?? '';
    _descriptionController.text = registrationData.shortDescription ?? '';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _businessNameController.dispose();
    _categoryController.dispose();
    _tinController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateData() {
    ref
        .read(registrationProvider.notifier)
        .setBusinessDetails(
          businessName: _businessNameController.text.trim(),
          businessEmail: _emailController.text.trim(),
          businessPhone: _phoneController.text.trim(),
          businessCategory: _categoryController.text.trim(),
          tinNumber: _tinController.text.trim(),
          shortDescription: _descriptionController.text.trim(),
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
            text: 'Setup Your Business Profile',
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeXLarge,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 100),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Subtitle
          FadeInText.body(
            text: 'Describe your business by filling in the details below',
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
                      icon: HugeIcons.strokeRoundedStore01,
                      size: 60,
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

          const SizedBox(height: AppSizes.spacingMedium),

          // Business Name Input
          AppInput(
            controller: _businessNameController,
            keyboardType: TextInputType.text,
            labelText: 'Business Name',
            hintText: 'Enter business name',
            onChanged: (_) => _updateData(),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedBuilding01,
                size: 20,
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          // Business Category Input
          AppInput(
            controller: _categoryController,
            keyboardType: TextInputType.text,
            labelText: 'Business Category',
            hintText: 'Select business category',
            onChanged: (_) => _updateData(),
            suffixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowDown01,
                size: 20,
              ),
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(icon: HugeIcons.strokeRoundedGrid, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          // TIN Number Input
          AppInput(
            controller: _tinController,
            keyboardType: TextInputType.text,
            labelText: 'TIN Number (Optional)',
            hintText: 'Enter TIN number',
            onChanged: (_) => _updateData(),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(icon: HugeIcons.strokeRoundedFile02, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          // Short Description Input
          AppInput(
            controller: _descriptionController,
            keyboardType: TextInputType.multiline,
            labelText: 'Short Description',
            hintText: 'Describe your business',
            maxLength: 200,
            showCounterText: true,
            onChanged: (_) => _updateData(),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(icon: HugeIcons.strokeRoundedNoteEdit, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
