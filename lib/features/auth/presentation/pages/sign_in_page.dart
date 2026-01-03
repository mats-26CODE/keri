import 'package:flutter/material.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_sizes.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../shared/widgets/buttons/app_button.dart';
import '../../../../shared/widgets/inputs/app_input.dart';
import '../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../shared/widgets/toggles/theme_toggle_icon.dart';
import '../../../../shared/widgets/toggles/language_toggle.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    // TODO: Implement sign in logic
    final phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty) {
      // Show error
      return;
    }
    // Navigate to OTP verification
    Navigator.of(context).pushNamed('/otp-verification');
  }

  void _handleRegister() {
    Navigator.of(context).pushNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.dark.background
          : AppColors.light.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.screenPaddingX,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Title
                          FadeInText.title(
                            text: 'Sign in to your account',
                            textAlign: TextAlign.center,
                            fontSize: AppSizes.fontSizeTitleXLarge,
                            duration: const Duration(milliseconds: 500),
                            delay: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                          ),

                          SizedBox(height: AppSizes.spacingSmall),
                          // Subtitle
                          FadeInText.body(
                            text:
                                "We'll send OTP codes to verify your phone number.",
                            textAlign: TextAlign.center,
                            fontSize: AppSizes.fontSizeLarge,
                            duration: const Duration(milliseconds: 500),
                            delay: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          ),

                          SizedBox(height: AppSizes.spacingLarge),

                          // Phone Number Input
                          AppInput(
                            controller: _phoneController,
                            focusNode: _phoneFocusNode,
                            keyboardType: TextInputType.phone,
                            hintText: 'Enter phone number',
                            maxLength: 10,
                            customContentPadding: const EdgeInsets.all(
                              AppSizes.inputSize,
                            ),
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

                          SizedBox(height: AppSizes.spacingLarge),

                          // Sign In Button
                          AppButton(text: 'Sign in', onPressed: _handleSignIn),

                          SizedBox(height: AppSizes.spacingLarge),
                          // Register Section
                          Center(
                            child: Text(
                              "Don't have an account?",
                              style: AppTextStyles.bodyStyle(
                                isDarkMode: isDarkMode,
                                color: isDarkMode
                                    ? AppColors.dark.mediumGrayColor
                                    : AppColors.light.mediumGrayColor,
                                fontSize: AppSizes.fontSizeMedium,
                              ),
                            ),
                          ),

                          SizedBox(height: AppSizes.spacingMedium),
                          // Register Button
                          AppButton(
                            text: 'Register',
                            onPressed: _handleRegister,
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

                          SizedBox(height: AppSizes.spacingLarge),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // Language and Theme Toggles - positioned at top left
            Positioned(
              top: AppSizes.spacingMedium,
              right: AppSizes.spacingMedium,
              child: Row(
                children: [
                  const LanguageToggle(size: 40),
                  SizedBox(width: AppSizes.spacingSmall),
                  const ThemeToggleIcon(size: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
