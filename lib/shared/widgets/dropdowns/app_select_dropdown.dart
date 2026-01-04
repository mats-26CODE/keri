import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/utils/app_text_styles.dart';

class AppSelectOption {
  final String value;
  final String label;
  final Widget? icon;

  const AppSelectOption({required this.value, required this.label, this.icon});
}

class AppSelectDropdown extends StatefulWidget {
  final List<AppSelectOption> options;
  final String? value;
  final String? hintText;
  final String? labelText;
  final String? error;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final bool enabled;

  const AppSelectDropdown({
    super.key,
    required this.options,
    this.value,
    this.hintText,
    this.labelText,
    this.error,
    this.prefixIcon,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<AppSelectDropdown> createState() => _AppSelectDropdownState();
}

class _AppSelectDropdownState extends State<AppSelectDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation =
        Tween<double>(
          begin: 0.0,
          end: 0.5, // 180 degrees = 0.5 turns
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDropdownChanged(bool isOpen) {
    if (isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: AppTextStyles.labelTextStyle(
              isDarkMode: isDarkMode,
              fontSize: AppSizes.fontSizeRegular,
            ),
          ),
          const SizedBox(height: AppSizes.spacingSmall),
        ],
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            value: widget.value,
            onMenuStateChange: _onDropdownChanged,
            hint: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.prefixIcon != null ? 0 : 14,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (widget.prefixIcon != null) ...[
                    widget.prefixIcon!,
                    const SizedBox(width: 14),
                  ],
                  Expanded(
                    child: Text(
                      widget.hintText ?? 'Select an option',
                      style: AppTextStyles.selectDropdownTextStyle(
                        isDarkMode: isDarkMode,
                        color: isDarkMode
                            ? AppColors.dark.placeholderColor
                            : AppColors.light.placeholderColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            items: widget.options.map((AppSelectOption option) {
              return DropdownMenuItem<String>(
                value: option.value,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.spacingSmall,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDarkMode
                            ? AppColors.dark.grayishBorderColor
                            : AppColors.light.grayishBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (option.icon != null) ...[
                        option.icon!,
                        const SizedBox(width: 14),
                      ],
                      Expanded(
                        child: Text(
                          option.label,
                          style: AppTextStyles.selectDropdownTextStyle(
                            isDarkMode: isDarkMode,
                            color: isDarkMode
                                ? AppColors.dark.text
                                : AppColors.light.text,
                            fontSize: AppSizes.fontSizeRegular,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            onChanged: widget.enabled
                ? (String? newValue) {
                    if (newValue != null) {
                      widget.onChanged?.call(newValue);
                    }
                  }
                : null,
            buttonStyleData: ButtonStyleData(
              height: AppSizes.inputHeight,
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.dark.background
                    : AppColors.light.background,
                borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
                border: Border.all(
                  color: widget.error != null
                      ? (isDarkMode
                            ? AppColors.dark.errorColor
                            : AppColors.light.errorColor)
                      : (isDarkMode
                            ? AppColors.dark.grayishBorderColor
                            : AppColors.light.grayishBorderColor),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? AppColors.shadowPrimarishColor.withAlpha(20)
                        : AppColors.shadowGrayishColor.withAlpha(40),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            iconStyleData: IconStyleData(
              icon: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle:
                        _rotationAnimation.value *
                        2 *
                        3.14159, // Convert turns to radians
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.dark.darkSurfaceComplimentColor
                            : AppColors.light.pureWhiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: isDarkMode
                                ? AppColors.shadowPrimarishColor.withAlpha(20)
                                : AppColors.shadowGrayishColor.withAlpha(40),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedArrowDown01,
                          color: isDarkMode
                              ? AppColors.dark.icon
                              : AppColors.light.icon,
                          size: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.dark.darkSurfaceComplimentColor
                    : AppColors.light.feWhitishColor,
                borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.black.withAlpha(80)
                        : AppColors.shadowPrimarishColor.withAlpha(60),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              offset: const Offset(0, 4),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            selectedItemBuilder: (BuildContext context) {
              return widget.options.map((AppSelectOption option) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.prefixIcon != null ? 0 : 14,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.prefixIcon != null) ...[
                          widget.prefixIcon!,
                          const SizedBox(width: 14),
                        ],
                        Expanded(
                          child: Text(
                            option.label,
                            style: AppTextStyles.selectDropdownTextStyle(
                              isDarkMode: isDarkMode,
                              color: isDarkMode
                                  ? AppColors.dark.text
                                  : AppColors.light.text,
                              fontSize: AppSizes.fontSizeMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ),
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.spacingTiny),
            child: Text(
              widget.error!,
              style: AppTextStyles.bodyStyle(
                isDarkMode: isDarkMode,
                color: isDarkMode
                    ? AppColors.dark.errorColor
                    : AppColors.light.errorColor,
                fontSize: AppSizes.fontSizeRegular,
              ),
            ),
          ),
      ],
    );
  }
}
