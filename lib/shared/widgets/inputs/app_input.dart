import 'package:flutter/material.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/utils/app_text_styles.dart';

class AppInput extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final String? error;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool showCounterText;
  final Color? counterColor;
  final Color? customBackgroundColor;
  final EdgeInsetsGeometry? customContentPadding;
  final double? customBorderRadius;
  final TextStyle? customTextStyle;
  final Color? cursorColor;
  final Color? customEnabledBorderColor;
  final Color? customFocusedBorderColor;
  final bool hideBoxShadow;
  final double? customHeight;
  final BorderSide? customEnabledBorderSide;
  final BorderSide? customFocusedBorderSide;

  const AppInput({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.error,
    this.onSubmitted,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.showCounterText = false,
    this.counterColor,
    this.customBackgroundColor,
    this.customContentPadding,
    this.customBorderRadius,
    this.customTextStyle,
    this.cursorColor,
    this.customEnabledBorderColor,
    this.customFocusedBorderColor,
    this.hideBoxShadow = false,
    this.customHeight,
    this.customEnabledBorderSide,
    this.customFocusedBorderSide,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTextStyles.inputTextStyle(
              isDarkMode: isDarkMode,
              color: isDarkMode ? AppColors.dark.text : AppColors.light.text,
              fontSize: AppSizes.fontSizeMedium,
            ),
          ),
          SizedBox(height: AppSizes.spacingTiny),
        ],
        Container(
          height: customHeight,
          decoration: BoxDecoration(
            color:
                customBackgroundColor ??
                (isDarkMode
                    ? AppColors.dark.darkSurfaceGrayColor
                    : AppColors.light.background),
            borderRadius: BorderRadius.circular(
              customBorderRadius ?? AppSizes.radiusLarge,
            ),
            boxShadow: hideBoxShadow
                ? null
                : [
                    BoxShadow(
                      color: isDarkMode
                          ? AppColors.dark.primarishShadowColor
                          : AppColors.light.grayishShadowColor,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            maxLength: maxLength,
            minLines: minLines,
            maxLines: maxLines,
            obscureText: obscureText,
            cursorColor:
                cursorColor ??
                (isDarkMode
                    ? AppColors.dark.mediumGrayColor
                    : AppColors.light.mediumGrayColor),
            style:
                customTextStyle ??
                AppTextStyles.inputTextStyle(
                  isDarkMode: isDarkMode,
                  color: isDarkMode
                      ? AppColors.dark.text
                      : AppColors.light.blackishColor,
                  fontSize: AppSizes.fontSizeMedium,
                ),
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            buildCounter:
                (
                  context, {
                  required currentLength,
                  required isFocused,
                  required maxLength,
                }) => showCounterText
                ? Text(
                    "$currentLength/$maxLength",
                    style: AppTextStyles.inputTextStyle(
                      isDarkMode: isDarkMode,
                      color:
                          counterColor ??
                          (isDarkMode
                              ? AppColors.dark.mediumGrayColor
                              : AppColors.light.darkishGrayColor),
                      fontSize: AppSizes.fontSizeSmall,
                    ),
                  )
                : const SizedBox.shrink(),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  customTextStyle ??
                  AppTextStyles.inputTextStyle(
                    isDarkMode: isDarkMode,
                    color: isDarkMode
                        ? AppColors.dark.mediumGrayColor
                        : AppColors.light.darkishGrayColor,
                    fontSize: AppSizes.fontSizeMedium,
                  ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  customBorderRadius ?? AppSizes.radiusLarge,
                ),
                borderSide: BorderSide(
                  color: isDarkMode
                      ? AppColors.dark.darkBorderColor
                      : AppColors.light.grayishBorderColor,
                  width: 2,
                ),
              ),
              enabledBorder: customEnabledBorderSide != null
                  ? UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        customBorderRadius ?? AppSizes.radiusLarge,
                      ),
                      borderSide: customEnabledBorderSide!,
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        customBorderRadius ?? AppSizes.radiusLarge,
                      ),
                      borderSide: error != null
                          ? BorderSide(
                              color: isDarkMode
                                  ? AppColors.dark.errorFadeColor
                                  : AppColors.light.errorColor,
                              width: 2,
                            )
                          : BorderSide(
                              color:
                                  customEnabledBorderColor ??
                                  (isDarkMode
                                      ? AppColors.dark.darkBorderColor
                                      : AppColors.light.grayishBorderColor),
                              width: 2,
                            ),
                    ),
              focusedBorder: customFocusedBorderSide != null
                  ? UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        customBorderRadius ?? AppSizes.radiusLarge,
                      ),
                      borderSide: customFocusedBorderSide!,
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        customBorderRadius ?? AppSizes.radiusLarge,
                      ),
                      borderSide: error != null
                          ? BorderSide(
                              color: isDarkMode
                                  ? AppColors.dark.errorFadeColor
                                  : AppColors.light.errorColor,
                              width: 2,
                            )
                          : BorderSide(
                              color:
                                  customFocusedBorderColor ??
                                  (isDarkMode
                                      ? AppColors.dark.primaryColor.withAlpha(100)
                                      : AppColors.light.primaryColor.withAlpha(100)),
                              width: 2,
                            ),
                    ),
              filled: true,
              fillColor:
                  customBackgroundColor ??
                  (isDarkMode
                      ? AppColors.dark.background
                      : AppColors.light.background),
              contentPadding:
                  customContentPadding ?? EdgeInsets.all(AppSizes.inputSize),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.spacingTiny),
            child: Text(
              error!,
              style: AppTextStyles.bodyStyle(
                isDarkMode: isDarkMode,
                color: isDarkMode
                    ? AppColors.dark.errorFadeColor
                    : AppColors.light.errorColor,
                fontSize: AppSizes.fontSizeRegular,
              ),
            ),
          ),
      ],
    );
  }
}
