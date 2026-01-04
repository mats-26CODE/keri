import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:toastification/toastification.dart';
import '../../../core/config/app_constants.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';

class AppToast {
  static void show({
    required BuildContext context,
    required String message,
    ToastificationType type = ToastificationType.info,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Custom background and icon color logic
    Color backgroundColor;
    Color iconColor;
    Widget? iconWidget;
    switch (type) {
      case ToastificationType.success:
        backgroundColor = isDarkMode
            ? AppColors.dark.successFadeColor
            : AppColors.light.successFadeColor;
        iconColor = isDarkMode
            ? AppColors.dark.successColor
            : AppColors.light.successColor;
        iconWidget = HugeIcon(
          icon: HugeIcons.strokeRoundedCheckmarkCircle01,
          color: iconColor,
          size: AppSizes.iconSizeRegular,
        );
        break;
      case ToastificationType.error:
        backgroundColor = isDarkMode
            ? AppColors.dark.errorFadeColor
            : AppColors.light.errorFadeColor;
        iconColor =
            isDarkMode ? AppColors.dark.errorColor : AppColors.light.errorColor;
        iconWidget = HugeIcon(
          icon: HugeIcons.strokeRoundedCancelCircle,
          color: iconColor,
          size: AppSizes.iconSizeRegular,
        );
        break;
      case ToastificationType.warning:
        backgroundColor = isDarkMode
            ? AppColors.dark.warningFadeColor
            : AppColors.light.warningFadeColor;
        iconColor = isDarkMode
            ? AppColors.dark.warningColor
            : AppColors.light.warningColor;
        iconWidget = HugeIcon(
          icon: HugeIcons.strokeRoundedAlertCircle,
          color: iconColor,
          size: AppSizes.iconSizeRegular,
        );
        break;
      case ToastificationType.info:
        backgroundColor = isDarkMode
            ? AppColors.dark.darkSurfaceGrayColor
            : AppColors.light.lightGrayColor;
        iconColor = isDarkMode
            ? AppColors.dark.primaryColor
            : AppColors.light.primaryColor;
        iconWidget = HugeIcon(
          icon: HugeIcons.strokeRoundedInformationCircle,
          color: iconColor,
          size: AppSizes.iconSizeRegular,
        );
        break;
    }

    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flatColored,
      autoCloseDuration:
          const Duration(seconds: AppConstants.toastAutoCloseDuration),
      description: Text(
        message,
        style: AppTextStyles.bodyStyle(
          isDarkMode: isDarkMode,
          color: isDarkMode ? AppColors.dark.text : AppColors.light.text,
          fontSize: AppSizes.fontSizeMedium,
        ),
      ),
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 400),
      icon: iconWidget,
      showIcon: false,
      showProgressBar: false,
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacingMedium,
        vertical: AppSizes.spacingTiny,
      ),
      margin: EdgeInsets.zero, // Remove all margins for full width
      borderRadius: BorderRadius.zero, // Remove border radius for full width
      boxShadow: const [
        BoxShadow(
          color: AppColors.shadowPrimarishColor,
          blurRadius: 16,
          offset: Offset(0, 0),
          spreadRadius: 10,
        ),
      ],
      borderSide: BorderSide.none, // Remove default border
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }
}

