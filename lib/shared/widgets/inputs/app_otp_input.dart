import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../core/config/app_constants.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/utils/app_text_styles.dart';

class AppOtpInput extends StatefulWidget {
  final int length;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;
  final String? error;
  final bool autoFocus;
  final int autoFocusDelay; // Delay in milliseconds before autofocus
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color? defaultBackgroundColor;
  final Color? focusedBackgroundColor;
  final Color? borderColor;

  const AppOtpInput({
    super.key,
    this.length = AppConstants.otpLength,
    this.onCompleted,
    this.onChanged,
    this.error,
    this.autoFocus = true,
    this.autoFocusDelay = 400, // Default 400ms delay after page transition
    this.keyboardType = TextInputType.number,
    this.controller,
    this.focusNode,
    this.defaultBackgroundColor,
    this.focusedBackgroundColor,
    this.borderColor,
  });

  @override
  State<AppOtpInput> createState() => _AppOtpInputState();
}

class _AppOtpInputState extends State<AppOtpInput> {
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();

    // Handle delayed autofocus
    if (widget.autoFocus && widget.autoFocusDelay > 0) {
      Future.delayed(Duration(milliseconds: widget.autoFocusDelay), () {
        if (mounted) {
          _internalFocusNode.requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    // Only dispose if we created it internally
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Calculate pin input size based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final totalSpacing = (widget.length - 1) * 12; // 8px spacing
    final pinSize = (screenWidth - totalSpacing) / widget.length;

    // Create default pin theme with filled style (connected look)
    final defaultPinTheme = PinTheme(
      width: pinSize,
      height: pinSize,
      textStyle:
          AppTextStyles.inputTextStyle(
            isDarkMode: isDarkMode,
            fontSize: AppSizes.fontSizeXLarge,
          ).copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode
                ? AppColors.dark.lightGrayColor
                : AppColors.light.darkishGrayColor,
          ),
      decoration: BoxDecoration(
        color:
            widget.defaultBackgroundColor ??
            (isDarkMode
                ? AppColors.dark.darkSurfaceComplimentColor.withAlpha(120)
                : AppColors.light.veryLightGrayColor),
        borderRadius: BorderRadius.zero,
      ),
    );

    // Create focused pin theme
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color:
            widget.focusedBackgroundColor ??
            (isDarkMode
                ? AppColors.dark.primaryColor.withAlpha(180)
                : AppColors.light.primaryColor),
        borderRadius: BorderRadius.zero,
      ),
      textStyle: defaultPinTheme.textStyle?.copyWith(
        color: isDarkMode
            ? AppColors.dark.pureWhiteColor
            : AppColors.light.pureWhiteColor,
      ),
    );

    // Create submitted pin theme (same as focused for consistency)
    final submittedPinTheme = focusedPinTheme;

    // Create error pin theme
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.dark.errorColor.withAlpha(40)
            : AppColors.light.errorColor.withAlpha(40),
        borderRadius: BorderRadius.zero,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  widget.borderColor ??
                  (isDarkMode
                      ? AppColors.dark.grayishBorderColor
                      : AppColors.light.grayishBorderColor),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge - 2),
            child: Pinput(
              length: widget.length,
              controller: widget.controller,
              focusNode: _internalFocusNode,
              autofocus:
                  false, // Disable Pinput's autofocus, we handle it manually
              keyboardType: widget.keyboardType,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              errorPinTheme: errorPinTheme,
              forceErrorState: widget.error != null,
              errorText: widget.error,
              onCompleted: widget.onCompleted,
              onChanged: widget.onChanged,
              hapticFeedbackType: HapticFeedbackType.mediumImpact,
              showCursor: true,
              errorTextStyle:
                  AppTextStyles.bodyStyle(
                    isDarkMode: isDarkMode,
                    fontSize: AppSizes.fontSizeRegular,
                  ).copyWith(
                    color: isDarkMode
                        ? AppColors.dark.errorColor
                        : AppColors.light.errorColor,
                  ),
              cursor: Container(
                width: 2,
                height: 24,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.dark.mediumGrayColor
                      : AppColors.light.mediumGrayColor,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              separatorBuilder: (index) =>
                  const SizedBox(width: 4), // Spacing between fields
            ),
          ),
        ),
        if (widget.error != null) ...[
          const SizedBox(height: AppSizes.spacingSmall),
          Padding(
            padding: const EdgeInsets.only(left: AppSizes.spacingSmall),
            child: Text(
              widget.error!,
              style:
                  AppTextStyles.bodyStyle(
                    isDarkMode: isDarkMode,
                    fontSize: AppSizes.fontSizeRegular,
                  ).copyWith(
                    color: isDarkMode
                        ? AppColors.dark.errorColor
                        : AppColors.light.errorColor,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}
