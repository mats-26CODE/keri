import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../../core/values/app_sizes.dart';
import '../../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../../shared/widgets/animations/slide_fade_in_animation.dart';
import '../../../../../../shared/widgets/inputs/app_input.dart';
import '../../../../../../shared/widgets/dropdowns/app_select_dropdown.dart';
import '../../../../../../shared/widgets/profile/app_profile_picture.dart';
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
  final TextEditingController _tinController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _businessLogo;
  String? _selectedCategory;

  // Business categories
  final List<AppSelectOption> _businessCategories = const [
    AppSelectOption(value: 'restaurant', label: 'Restaurant & Food'),
    AppSelectOption(value: 'retail', label: 'Retail & Shopping'),
    AppSelectOption(value: 'pharmacy', label: 'Pharmacy & Healthcare'),
    AppSelectOption(value: 'grocery', label: 'Grocery & Supermarket'),
    AppSelectOption(value: 'electronics', label: 'Electronics & Technology'),
    AppSelectOption(value: 'fashion', label: 'Fashion & Apparel'),
    AppSelectOption(value: 'services', label: 'Services & Professional'),
    AppSelectOption(value: 'logistics', label: 'Logistics & Transport'),
    AppSelectOption(value: 'other', label: 'Other'),
  ];

  @override
  void initState() {
    super.initState();
    final registrationData = ref.read(registrationProvider);
    _phoneController.text = registrationData.phoneNumber ?? '';
    _emailController.text = registrationData.businessEmail ?? '';
    _businessNameController.text = registrationData.businessName ?? '';
    _selectedCategory = registrationData.businessCategory;
    _tinController.text = registrationData.tinNumber ?? '';
    _descriptionController.text = registrationData.shortDescription ?? '';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _businessNameController.dispose();
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
          businessCategory: _selectedCategory ?? '',
          tinNumber: _tinController.text.trim(),
          shortDescription: _descriptionController.text.trim(),
        );
    ref
        .read(registrationProvider.notifier)
        .setPhoneNumber(_phoneController.text.trim());
  }

  void _handleImagePicked(File? image) {
    setState(() {
      _businessLogo = image;
    });
    // TODO: Store logo in registration provider when we add the field
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              text: 'Setup Your Business Profile',
              fontSize: AppSizes.fontSizeTitleXXLarge,
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 100),
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Subtitle
          SlideFadeInAnimation(
            duration: const Duration(milliseconds: 300),
            delay: const Duration(milliseconds: 100),
            beginOffset: const Offset(0, 0.1),
            child: FadeInText.body(
              text: 'Describe your business by filling in the details below',
              fontSize: AppSizes.fontSizeMedium,
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 100),
            ),
          ),

          const SizedBox(height: AppSizes.spacingXLarge),

          // Business Logo
          AppProfilePicture(
            size: 120,
            imageFile: _businessLogo,
            showEditButton: true,
            onImagePicked: _handleImagePicked,
            enableRotatingBorder: true,
            borderWidth: 4,
            alignment: Alignment.center,
          ),

          const SizedBox(height: AppSizes.spacingXLarge),

          // Phone Number Input
          AppInput(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            labelText: 'Phone Number',
            hintText: 'Enter phone number',
            maxLength: 10,
            onChanged: (_) => _updateData(),
            prefixIcon: IntrinsicWidth(
              child: Center(
                child: FadeInText.heading(
                  text: "🇹🇿",
                  textAlign: TextAlign.center,
                  fontSize: AppSizes.fontSizeLarge,
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Email Input
          AppInput(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: 'Email Address',
            hintText: 'Enter email address',
            onChanged: (_) => _updateData(),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedMailAtSign01,
                size: AppSizes.iconSizeMedium,
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

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
                icon: HugeIcons.strokeRoundedStore03,
                size: AppSizes.iconSizeMedium,
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Business Category Dropdown
          AppSelectDropdown(
            options: _businessCategories,
            value: _selectedCategory,
            labelText: 'Business Category',
            hintText: 'Select business category',
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedGridView,
              size: AppSizes.iconSizeMedium,
            ),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
              _updateData();
            },
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // TIN Number Input
          AppInput(
            controller: _tinController,
            keyboardType: TextInputType.text,
            labelText: 'TIN Number',
            hintText: 'Enter TIN number',
            onChanged: (_) => _updateData(),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedFile02,
                size: AppSizes.iconSizeMedium,
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Short Description Input
          AppInput(
            controller: _descriptionController,
            keyboardType: TextInputType.multiline,
            labelText: 'Short Description (Optional)',
            hintText: 'Describe your business',
            maxLength: 200,
            minLines: 4,
            maxLines: 6,
            showCounterText: true,
            onChanged: (_) => _updateData(),
          ),

          const SizedBox(height: AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
