import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';
import '../../../core/values/app_colors.dart';
import '../animations/rotating_border_animation.dart';
import '../animations/scale_animation_tap_wrapper.dart';
import '../toast/app_toast.dart';

class AppProfilePicture extends StatefulWidget {
  final double size;
  final String? imageUrl;
  final File? imageFile;
  final bool showEditButton;
  final VoidCallback? onEditPressed;
  final Function(File?)? onImagePicked;
  final bool enableRotatingBorder;
  final double? borderWidth;
  final Color? placeholderBackgroundColor;
  final Color? placeholderIconColor;
  final Color? editButtonBackgroundColor;
  final bool showBorder;
  final bool showShadow;

  const AppProfilePicture({
    super.key,
    this.size = 120,
    this.imageUrl,
    this.imageFile,
    this.showEditButton = false,
    this.onEditPressed,
    this.onImagePicked,
    this.enableRotatingBorder = false,
    this.borderWidth,
    this.placeholderBackgroundColor,
    this.placeholderIconColor,
    this.editButtonBackgroundColor,
    this.showBorder = true,
    this.showShadow = true,
  });

  @override
  State<AppProfilePicture> createState() => _AppProfilePictureState();
}

class _AppProfilePictureState extends State<AppProfilePicture>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        final File imageFile = File(image.path);
        widget.onImagePicked?.call(imageFile);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (context.mounted) {
        AppToast.show(
          context: context,
          message: 'Failed to pick image',
          type: ToastificationType.error,
        );
      }
    }
  }

  Widget _buildProfileContent(bool isDarkMode) {
    // Show actual image if available
    if (widget.imageFile != null) {
      return _buildImageContainer(
        child: Image.file(
          widget.imageFile!,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
        ),
        isDarkMode: isDarkMode,
      );
    }

    // Show network image if URL is provided
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return _buildImageContainer(
        child: Image.network(
          widget.imageUrl!,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildLoadingPlaceholder(isDarkMode);
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder(
              isDarkMode,
              showIcon: !widget.showEditButton,
            );
          },
        ),
        isDarkMode: isDarkMode,
      );
    }

    // Show placeholder (without icon if edit is enabled)
    return _buildPlaceholder(isDarkMode, showIcon: !widget.showEditButton);
  }

  Widget _buildImageContainer({
    required Widget child,
    required bool isDarkMode,
  }) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: widget.showBorder
            ? Border.all(
                color: isDarkMode
                    ? AppColors.dark.grayishBorderColor.withAlpha(100)
                    : AppColors.light.grayishBorderColor.withAlpha(100),
                width: 2,
              )
            : null,
        boxShadow: widget.showShadow
            ? [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black.withAlpha(80)
                      : AppColors.shadowPrimarishColor.withAlpha(40),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black.withAlpha(40)
                      : AppColors.shadowPrimarishColor.withAlpha(20),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                  spreadRadius: -2,
                ),
              ]
            : null,
      ),
      child: ClipOval(child: child),
    );
  }

  Widget _buildLoadingPlaceholder(bool isDarkMode) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [
                  AppColors.dark.darkSurfaceGrayColor,
                  AppColors.dark.darkSurfaceComplimentColor,
                ]
              : [
                  AppColors.light.lightGrayColor,
                  AppColors.light.lightGrayColor.withAlpha(150),
                ],
        ),
      ),
      child: Center(
        child: SizedBox(
          width: widget.size * 0.3,
          height: widget.size * 0.3,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              isDarkMode
                  ? AppColors.dark.primaryColor
                  : AppColors.light.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(bool isDarkMode, {bool showIcon = true}) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.placeholderBackgroundColor != null
              ? [
                  widget.placeholderBackgroundColor!,
                  widget.placeholderBackgroundColor!,
                ]
              : isDarkMode
              ? [
                  AppColors.dark.darkSurfaceGrayColor,
                  AppColors.dark.darkSurfaceComplimentColor,
                ]
              : [
                  AppColors.light.lightGrayColor,
                  AppColors.light.lightGrayColor.withAlpha(200),
                ],
        ),
        border: widget.showBorder
            ? Border.all(
                color: isDarkMode
                    ? AppColors.dark.grayishBorderColor.withAlpha(100)
                    : AppColors.light.grayishBorderColor.withAlpha(100),
                width: 2,
              )
            : null,
        boxShadow: widget.showShadow
            ? [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black.withAlpha(60)
                      : AppColors.shadowPrimarishColor.withAlpha(30),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: showIcon
          ? Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedUserAi,
                size: widget.size * 0.5,
                color:
                    widget.placeholderIconColor ??
                    (isDarkMode
                        ? AppColors.dark.mediumGrayColor.withAlpha(180)
                        : AppColors.light.mediumGrayColor.withAlpha(180)),
              ),
            )
          : null,
    );
  }

  Widget _buildEditButton(bool isDarkMode, BuildContext context) {
    return Positioned.fill(
      child: ScaleAnimationTapWrapper(
        onTap: widget.onEditPressed ?? () => _pickImage(context),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode
                ? AppColors.dark.primaryColor.withAlpha(40)
                : AppColors.light.primaryColor.withAlpha(40),
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(widget.size * 0.08),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    (widget.editButtonBackgroundColor ??
                            (isDarkMode
                                ? AppColors.dark.primaryColor
                                : AppColors.light.primaryColor))
                        .withAlpha(200),
                boxShadow: [
                  BoxShadow(
                    color:
                        (widget.editButtonBackgroundColor ??
                                (isDarkMode
                                    ? AppColors.dark.primaryColor
                                    : AppColors.light.primaryColor))
                            .withAlpha(150),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedImageAdd01,
                size: widget.size * 0.2,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    Widget profileWidget = ScaleTransition(
      scale: _scaleAnimation,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildProfileContent(isDarkMode),
            if (widget.showEditButton) _buildEditButton(isDarkMode, context),
          ],
        ),
      ),
    );

    // Wrap with rotating border if enabled
    if (widget.enableRotatingBorder) {
      final effectiveBorderWidth = widget.borderWidth ?? 8.0;
      final containerSize = widget.size + (effectiveBorderWidth * 4);

      profileWidget = SizedBox(
        width: containerSize,
        height: containerSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glow effect behind rotating border
            Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:
                        (isDarkMode
                                ? AppColors.dark.primaryColor
                                : AppColors.light.primaryColor)
                            .withAlpha(60),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            // Rotating border
            RotatingBorderAnimation(
              borderWidth: effectiveBorderWidth,
              duration: const Duration(seconds: 4),
              topColor: isDarkMode
                  ? AppColors.dark.primaryColor
                  : AppColors.light.primaryColor,
              rightColor: isDarkMode
                  ? AppColors.dark.warningColor
                  : AppColors.light.warningColor,
              bottomColor: isDarkMode
                  ? AppColors.dark.successColor
                  : AppColors.light.successColor,
              leftColor: isDarkMode
                  ? AppColors.dark.primaryDeepColor
                  : AppColors.light.primaryDeepColor,
              child: Center(
                child: Container(
                  width: widget.size + (effectiveBorderWidth * 2),
                  height: widget.size + (effectiveBorderWidth * 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkMode
                        ? AppColors.dark.background
                        : AppColors.light.background,
                  ),
                  child: Center(
                    child: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            (isDarkMode
                                    ? AppColors.dark.primaryColor
                                    : AppColors.light.primaryColor)
                                .withAlpha(20),
                            (isDarkMode
                                    ? AppColors.dark.primaryColor
                                    : AppColors.light.primaryColor)
                                .withAlpha(5),
                          ],
                        ),
                      ),
                      child: Center(child: profileWidget),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Center(child: profileWidget);
  }
}
