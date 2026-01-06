import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../../core/values/app_sizes.dart';
import '../../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../../shared/widgets/animations/slide_fade_in_animation.dart';
import '../../../../../../shared/widgets/inputs/app_input.dart';
import '../../../../../../shared/widgets/profile/app_profile_picture.dart';
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
  File? _profileImage;

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

  void _handleImagePicked(File? image) {
    setState(() {
      _profileImage = image;
    });
    // TODO: Store image in registration provider when we add the field
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
              text: 'Setup Your Personal Profile',
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
              text: "We'll send OTP codes to verify your phone number",
              fontSize: AppSizes.fontSizeMedium,
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 100),
            ),
          ),

          const SizedBox(height: AppSizes.spacingXLarge),

          // Profile Picture
          AppProfilePicture(
            size: 120,
            imageFile: _profileImage,
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
              child: HugeIcon(icon: HugeIcons.strokeRoundedMail01, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
