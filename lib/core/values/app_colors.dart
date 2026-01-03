import 'package:flutter/material.dart';

/// Colors used in the Keri app, defined for both light and dark theme.
class AppColors {
  // Primary brand colors for Keri
  static const Color primaryColor = Color(0xFF1362CB);
  static const Color primaryDeepColor = Color(0xFF501EA7);

  // Base colors
  static const Color pureWhiteColor = Color(0xFFFFFFFF);
  static const Color bgWhitishColor = Color(0xFFFCFCFC);
  static const Color darkTextColor = Color(0xFFE9EDEF);
  static const Color fadeWhiteColor = Color(0xFFE0E0E0);
  static const Color feWhitishColor = Color(0xFFFEFEFE);
  static const Color blackishColor = Color(0xFF1C1C1C);
  static const Color veryLightGrayColor = Color(0xFFF8F8F8);
  static const Color lightGrayColor = Color(0xFFF1F1F1);
  static const Color borderGrayishColor = Color(0xFFE1E1E1);
  static const Color darkishGrayColor = Color(0xFF5A5A5A);
  static const Color darkSurfaceGrayColor = Color(0xFF0E111E);
  static const Color darkSurfaceColor = Color(0xFF111B21);
  static const Color darkSurfaceComplimentColor = Color(0xFF202C33);
  static const Color mediumGrayColor = Color(0xFFA9A9A9);

  // Status colors
  static const Color successColor = Color(0xFF3DD67B);
  static const Color warningColor = Color(0xFFFFD530);
  static const Color errorColor = Color(0xFFE20F0F);
  static const Color successFadeColor = Color(0xFFD9FFE8);
  static const Color warningFadeColor = Color(0xFFFFF7D8);
  static const Color errorFadeColor = Color(0xFFFFDBDB);
  static const Color darkErrorFadeColor = Color(0xFFB57474);

  // Shadow colors
  static const Color shadowPrimarishColor = Color(0x5015193D);
  static const Color shadowGrayishColor = Color(0x50E3E3E3);
  static const Color shadowBlackishColor = Color(0x50212121);
  static const Color darkIconColor = Color(0xFFE9EDEF);

  // -> Light theme
  static final light = _LightColors();

  // -> Dark theme
  static final dark = _DarkColors();
}

class _LightColors {
  final Color text = AppColors.blackishColor;
  final Color background = AppColors.bgWhitishColor;
  final Color icon = AppColors.darkishGrayColor;
  final Color tabIconDefault = AppColors.darkishGrayColor;
  final Color tabIconSelected = AppColors.primaryColor;
  final Color toastSuccessColor = AppColors.successFadeColor;
  final Color toastWarningColor = AppColors.warningFadeColor;
  final Color toastErrorColor = AppColors.errorFadeColor;
  final Color linkColor = AppColors.primaryColor;
  final Color inputColor = AppColors.lightGrayColor;
  final Color placeholderColor = AppColors.darkishGrayColor;
  final Color grayishBorderColor = AppColors.borderGrayishColor;
  final Color lightBorderColor = AppColors.lightGrayColor;
  final Color rippleColor = AppColors.lightGrayColor;
  final Color skeletonColor = AppColors.lightGrayColor;
  final Color sheetColor = AppColors.lightGrayColor;
  final Color card = AppColors.pureWhiteColor;
  final Color primaryColor = AppColors.primaryColor;
  final Color primaryDeepColor = AppColors.primaryDeepColor;
  final Color pureWhiteColor = AppColors.pureWhiteColor;
  final Color feWhitishColor = AppColors.feWhitishColor;
  final Color blackishColor = AppColors.blackishColor;
  final Color veryLightGrayColor = AppColors.veryLightGrayColor;
  final Color lightGrayColor = AppColors.lightGrayColor;
  final Color darkishGrayColor = AppColors.darkishGrayColor;
  final Color mediumGrayColor = AppColors.mediumGrayColor;
  final Color successColor = AppColors.successColor;
  final Color warningColor = AppColors.warningColor;
  final Color errorColor = AppColors.errorColor;
  final Color warningFadeColor = AppColors.warningFadeColor;
  final Color successFadeColor = AppColors.successFadeColor;
  final Color errorFadeColor = AppColors.errorFadeColor;
  final Color primarishShadowColor = AppColors.shadowPrimarishColor;
  final Color grayishShadowColor = AppColors.shadowGrayishColor;
  final Color blackishShadowColor = AppColors.shadowBlackishColor;
}

class _DarkColors {
  final Color text = AppColors.darkTextColor;
  final Color background = AppColors.darkSurfaceColor;
  final Color icon = AppColors.darkIconColor;
  final Color tabIconDefault = AppColors.fadeWhiteColor;
  final Color tabIconSelected = AppColors.primaryColor;
  final Color toastSuccessColor = AppColors.successFadeColor;
  final Color toastWarningColor = AppColors.warningFadeColor;
  final Color toastErrorColor = AppColors.errorFadeColor;
  final Color linkColor = AppColors.primaryColor;
  final Color inputColor = AppColors.darkishGrayColor;
  final Color placeholderColor = AppColors.fadeWhiteColor;
  final Color grayishBorderColor = AppColors.borderGrayishColor;
  final Color sheetColor = AppColors.darkSurfaceComplimentColor;
  final Color card = AppColors.darkSurfaceComplimentColor;
  final Color darkSurfaceColor = AppColors.darkSurfaceColor;
  final Color darkBorderColor = AppColors.darkSurfaceComplimentColor;
  final Color darkSurfaceComplimentColor = AppColors.darkSurfaceComplimentColor;
  final Color primaryColor = AppColors.primaryColor;
  final Color primaryDeepColor = AppColors.primaryDeepColor;
  final Color pureWhiteColor = AppColors.pureWhiteColor;
  final Color feWhitishColor = AppColors.feWhitishColor;
  final Color blackishColor = AppColors.darkishGrayColor;
  final Color veryLightGrayColor = AppColors.veryLightGrayColor;
  final Color lightGrayColor = AppColors.lightGrayColor;
  final Color mediumGrayColor = AppColors.mediumGrayColor;
  final Color darkishGrayColor = AppColors.darkishGrayColor;
  final Color darkSurfaceGrayColor = AppColors.darkSurfaceGrayColor;
  final Color successColor = AppColors.successColor;
  final Color warningColor = AppColors.warningColor;
  final Color errorColor = AppColors.errorColor;
  final Color warningFadeColor = AppColors.warningFadeColor;
  final Color successFadeColor = AppColors.successFadeColor;
  final Color errorFadeColor = AppColors.darkErrorFadeColor;
  final Color primarishShadowColor = AppColors.shadowPrimarishColor;
  final Color grayishShadowColor = AppColors.shadowGrayishColor;
  final Color blackishShadowColor = AppColors.shadowBlackishColor;
}
