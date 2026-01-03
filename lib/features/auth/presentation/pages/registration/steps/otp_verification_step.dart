import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/values/app_colors.dart';
import '../../../../../../core/values/app_sizes.dart';
import '../../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../../shared/widgets/buttons/app_button.dart';
import '../../../../../../shared/widgets/inputs/app_input.dart';
import '../../../providers/registration_provider.dart';

class OtpVerificationStep extends ConsumerStatefulWidget {
  const OtpVerificationStep({super.key});

  @override
  ConsumerState<OtpVerificationStep> createState() =>
      _OtpVerificationStepState();
}

class _OtpVerificationStepState extends ConsumerState<OtpVerificationStep> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _handleVerify() {
    final otp = _otpController.text.trim();
    if (otp.length == 6) {
      ref.read(registrationProvider.notifier).setOtp(otp);
      // TODO: Implement OTP verification logic
      // On success, navigate to home
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void _handleResend() {
    // TODO: Implement resend OTP logic
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingX),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          FadeInText.heading(
            text: 'Verify Phone Number',
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeXXLarge,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 100),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          // Subtitle
          FadeInText.body(
            text: 'Enter verification code received via SMS',
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeMedium,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 200),
          ),

          const SizedBox(height: AppSizes.spacingXXLarge),

          // OTP Input
          AppInput(
            controller: _otpController,
            keyboardType: TextInputType.number,
            labelText: 'OTP',
            hintText: 'Enter 6 digits',
            maxLength: 6,
            showCounterText: true,
            onChanged: (value) {
              if (value.length == 6) {
                _handleVerify();
              }
            },
          ),

          const SizedBox(height: AppSizes.spacingXXLarge),

          // Verify Button
          AppButton(text: 'Verify', onPressed: _handleVerify),

          const SizedBox(height: AppSizes.spacingLarge),

          // Resend OTP
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Haven't received the code? ",
                style: TextStyle(
                  fontSize: AppSizes.fontSizeMedium,
                  color: isDarkMode
                      ? AppColors.dark.mediumGrayColor
                      : AppColors.light.mediumGrayColor,
                ),
              ),
              GestureDetector(
                onTap: _handleResend,
                child: Text(
                  'Resend',
                  style: TextStyle(
                    fontSize: AppSizes.fontSizeMedium,
                    color: isDarkMode
                        ? AppColors.dark.primaryColor
                        : AppColors.light.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
