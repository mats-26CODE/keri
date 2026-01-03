import 'package:flutter/material.dart';
import '../../../core/utils/app_text_styles.dart';
import 'fade_in_animation.dart';

/// A text widget with fade-in animation using AppTextStyles
class FadeInText extends StatelessWidget {
  final String text;
  final TextStyle Function({
    required bool isDarkMode,
    Color? color,
    double? fontSize,
  })
  styleBuilder;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  const FadeInText({
    super.key,
    required this.text,
    required this.styleBuilder,
    this.color,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve = Curves.easeInOut,
  });

  // Convenient factory constructors for different text styles

  /// Creates a fade-in heading text
  factory FadeInText.heading({
    Key? key,
    required String text,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
  }) {
    return FadeInText(
      key: key,
      text: text,
      styleBuilder: AppTextStyles.headingStyle,
      color: color,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      duration: duration,
      delay: delay,
      curve: curve,
    );
  }

  /// Creates a fade-in body text
  factory FadeInText.body({
    Key? key,
    required String text,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
  }) {
    return FadeInText(
      key: key,
      text: text,
      styleBuilder: AppTextStyles.bodyStyle,
      color: color,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      duration: duration,
      delay: delay,
      curve: curve,
    );
  }

  /// Creates a fade-in title text
  factory FadeInText.title({
    Key? key,
    required String text,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
  }) {
    return FadeInText(
      key: key,
      text: text,
      styleBuilder: AppTextStyles.titleStyle,
      color: color,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      duration: duration,
      delay: delay,
      curve: curve,
    );
  }

  /// Creates a fade-in subtitle text
  factory FadeInText.subtitle({
    Key? key,
    required String text,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
  }) {
    return FadeInText(
      key: key,
      text: text,
      styleBuilder: AppTextStyles.subtitleStyle,
      color: color,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      duration: duration,
      delay: delay,
      curve: curve,
    );
  }

  /// Creates a fade-in caption text
  factory FadeInText.caption({
    Key? key,
    required String text,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
  }) {
    return FadeInText(
      key: key,
      text: text,
      styleBuilder: AppTextStyles.captionTextStyle,
      color: color,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      duration: duration,
      delay: delay,
      curve: curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return FadeInAnimation(
      duration: duration,
      delay: delay,
      curve: curve,
      child: Text(
        text,
        style: styleBuilder(
          isDarkMode: isDarkMode,
          color: color,
          fontSize: fontSize,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
