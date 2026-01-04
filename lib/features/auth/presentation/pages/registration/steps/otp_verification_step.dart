import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keri/shared/widgets/animations/animations.dart';
import '../../../../../../core/values/app_sizes.dart';
import '../../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../../shared/widgets/animations/scale_animation_tap_wrapper.dart';
import '../../../../../../shared/widgets/inputs/app_otp_input.dart';
import '../../../providers/registration_provider.dart';

class OtpVerificationStep extends ConsumerStatefulWidget {
  const OtpVerificationStep({super.key});

  @override
  ConsumerState<OtpVerificationStep> createState() =>
      _OtpVerificationStepState();
}

class _OtpVerificationStepState extends ConsumerState<OtpVerificationStep> {
  final TextEditingController _otpController = TextEditingController();
  String? _errorMessage;
  Timer? _timer;
  int _resendCountdown = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _resendCountdown = 60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _handleVerify(String otp) {
    if (otp.length == 6) {
      setState(() {
        _errorMessage = null;
      });
      ref.read(registrationProvider.notifier).setOtp(otp);
      // TODO: Implement OTP verification logic
      // On success, navigate to home
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      setState(() {
        _errorMessage = 'Please enter a valid 6-digit code';
      });
    }
  }

  void _handleResend() {
    if (_resendCountdown == 0) {
      // TODO: Implement resend OTP logic
      setState(() {
        _errorMessage = null;
        _otpController.clear();
      });
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
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
              text: 'Verify Phone Number',
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
              text: 'Enter verification code received via SMS',
              fontSize: AppSizes.fontSizeMedium,
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 100),
            ),
          ),

          const SizedBox(height: AppSizes.spacingXLarge),

          // OTP Input
          SlideFadeInAnimation(
            duration: const Duration(milliseconds: 300),
            delay: const Duration(milliseconds: 200),
            beginOffset: const Offset(0, 0.1),
            child: AppOtpInput(
              controller: _otpController,
              error: _errorMessage,
              onCompleted: _handleVerify,
              onChanged: (value) {
                if (_errorMessage != null) {
                  setState(() {
                    _errorMessage = null;
                  });
                }
              },
            ),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          // Resend OTP
          Container(
            child: _resendCountdown > 0
                ? FadeInText.body(
                    text:
                        "Didn't receive codes? Resend in ${_resendCountdown}s",
                    fontSize: AppSizes.fontSizeMedium,
                    duration: const Duration(milliseconds: 300),
                    delay: const Duration(milliseconds: 100),
                  )
                : ScaleAnimationTapWrapper(
                    onTap: _handleResend,
                    child: FadeInText.body(
                      text: "Didn't receive codes? Resend Now",
                      fontSize: AppSizes.fontSizeMedium,
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 100),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
