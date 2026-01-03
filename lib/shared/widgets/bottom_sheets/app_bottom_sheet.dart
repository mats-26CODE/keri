import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../buttons/app_icon_button.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final double? height;
  final Color? backgroundColor;
  final bool showDragHandle;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final bool isDismissible;
  final bool enableDrag;
  final bool bounce;
  final bool showCloseButton;
  final Widget? footer;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.height,
    this.backgroundColor,
    this.showDragHandle = true,
    this.padding,
    this.borderRadius,
    this.isDismissible = true,
    this.enableDrag = true,
    this.bounce = false,
    this.showCloseButton = true,
    this.footer,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double? height,
    Color? backgroundColor,
    bool showDragHandle = true,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    bool isDismissible = true,
    bool enableDrag = true,
    bool bounce = false,
    bool showCloseButton = false,
    Widget? footer,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return showMaterialModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      bounce: bounce,
      duration: const Duration(milliseconds: 200),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AppBottomSheet(
          height: height,
          backgroundColor:
              backgroundColor ??
              (isDarkMode
                  ? AppColors.dark.sheetColor
                  : AppColors.light.sheetColor),
          showDragHandle: showDragHandle,
          padding: padding,
          borderRadius: borderRadius,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          showCloseButton: showCloseButton,
          footer: footer,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final defaultBorderRadius = BorderRadius.vertical(
      top: Radius.circular(AppSizes.sheetBorderRadius),
    );

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.scaffoldBackgroundColor,
        borderRadius: borderRadius ?? defaultBorderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDragHandle) ...[
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.dark.darkishGrayColor.withAlpha(120)
                      : AppColors.light.darkishGrayColor.withAlpha(120),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (showCloseButton) ...[
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, right: 20),
                child: AppIconButton(
                  icon: const Icon(Icons.close, size: 22),
                  onPressed: () => Navigator.of(context).pop(),
                  isOutlined: true,
                  size: 24,
                  borderColor: Colors.transparent,
                  iconColor: isDarkMode
                      ? AppColors.dark.icon
                      : AppColors.light.icon,
                ),
              ),
            ),
          ],
          // Main content area
          Flexible(
            child: Padding(
              padding:
                  padding ??
                  const EdgeInsets.symmetric(
                    horizontal: AppSizes.screenPaddingX,
                    vertical: AppSizes.spacingSmall,
                  ),
              child: child,
            ),
          ),
          // Footer - always at bottom
          if (footer != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.screenPaddingX,
                vertical: AppSizes.screenPaddingY,
              ),
              decoration: BoxDecoration(
                color: backgroundColor ?? theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(borderRadius?.bottomLeft.x ?? 20),
                ),
              ),
              child: footer!,
            ),
        ],
      ),
    );
  }
}
