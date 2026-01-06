import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_sizes.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../shared/widgets/animations/scale_animation_tap_wrapper.dart';
import '../../../../shared/widgets/buttons/app_button.dart';

class DeliveryRequestPanel extends ConsumerStatefulWidget {
  const DeliveryRequestPanel({super.key});

  @override
  ConsumerState<DeliveryRequestPanel> createState() =>
      _DeliveryRequestPanelState();
}

class _DeliveryRequestPanelState extends ConsumerState<DeliveryRequestPanel> {
  final PanelController _panelController = PanelController();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _destinationFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Listen to focus changes
    _destinationFocusNode.addListener(() {
      if (_destinationFocusNode.hasFocus) {
        _panelController.open();
      } else {
        _panelController.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    return SlidingUpPanel(
      controller: _panelController,
      minHeight: screenHeight * 0.35,
      maxHeight: screenHeight * 0.75,
      backdropEnabled: false,
      renderPanelSheet: false,
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      snapPoint: 0.5,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppSizes.radiusXXLarge),
        topRight: Radius.circular(AppSizes.radiusXXLarge),
      ),
      panelBuilder: (scrollController) =>
          _buildPanel(context, scrollController, isDarkMode),
    );
  }

  Widget _buildPanel(
    BuildContext context,
    ScrollController scrollController,
    bool isDarkMode,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.dark.darkSurfaceGrayColor
            : AppColors.light.pureWhiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radiusXXLarge),
          topRight: Radius.circular(AppSizes.radiusXXLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle
          _DragHandle(isDarkMode: isDarkMode),

          // Scrollable Content
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.screenPaddingX,
              ),
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(height: AppSizes.spacingSmall),

                // Title
                Text(
                  'Start Your Parcel / Cargo\nDelivery',
                  style: AppTextStyles.headingStyle(
                    isDarkMode: isDarkMode,
                    fontSize: AppSizes.fontSizeTitleLarge,
                  ),
                ),

                const SizedBox(height: AppSizes.spacingLarge),

                // Search Input
                _SearchInput(
                  controller: _destinationController,
                  focusNode: _destinationFocusNode,
                  isDarkMode: isDarkMode,
                ),

                const SizedBox(height: AppSizes.spacingLarge),

                // Pickup Location
                _buildLocationCard(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedLocationUser03,
                    size: 20,
                  ),
                  title: 'Pickup',
                  subtitle: 'Your current location',
                  onEditTap: () {
                    // Handle pickup location edit
                  },
                  onLocationTap: () {
                    // Handle pickup location view/change
                  },
                  isDarkMode: isDarkMode,
                ),

                const SizedBox(height: AppSizes.spacingMedium),

                // Drop-off Location
                _buildLocationCard(
                  icon: HugeIcon(icon: HugeIcons.strokeRoundedMail01, size: 20),
                  title: 'Drop off',
                  subtitle: 'Masaki, Universal Plaza',
                  onEditTap: () {
                    // Handle drop-off location edit
                  },
                  onLocationTap: () {
                    // Handle drop-off location view/change
                  },
                  isDarkMode: isDarkMode,
                ),

                const SizedBox(height: AppSizes.spacingXLarge),

                // Start Delivery Button
                AppButton(
                  text: 'Start Delivery',
                  onPressed: () {
                    // Handle start delivery
                  },
                ),

                const SizedBox(height: AppSizes.spacingXLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard({
    required dynamic icon,
    required String title,
    required String subtitle,
    required VoidCallback onEditTap,
    required VoidCallback onLocationTap,
    required bool isDarkMode,
  }) {
    return ScaleAnimationTapWrapper(
      onTap: onLocationTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingMedium),
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColors.dark.darkSurfaceComplimentColor
              : AppColors.light.lightGrayColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.paddingSmall),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.dark.primaryColor.withAlpha(100)
                          : AppColors.light.primaryColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: IconTheme(
                      data: IconThemeData(
                        color: isDarkMode
                            ? AppColors.dark.primaryColor
                            : AppColors.light.primaryColor,
                        size: AppSizes.iconSizeMedium,
                      ),
                      child: icon,
                    ),
                  ),
                  const SizedBox(width: AppSizes.spacingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.subtitleStyle(
                            isDarkMode: isDarkMode,
                            fontSize: AppSizes.fontSizeSmall,
                            color: isDarkMode
                                ? AppColors.dark.mediumGrayColor
                                : AppColors.light.mediumGrayColor,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacingTiny),
                        Text(
                          subtitle,
                          style: AppTextStyles.bodyStyle(
                            isDarkMode: isDarkMode,
                            fontSize: AppSizes.fontSizeMedium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ScaleAnimationTapWrapper(
              onTap: onEditTap,
              child: Container(
                padding: const EdgeInsets.all(AppSizes.paddingSmall),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.dark.darkSurfaceGrayColor
                      : AppColors.light.pureWhiteColor,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedPencilEdit01,
                  size: AppSizes.iconSizeSmall,
                  color: isDarkMode
                      ? AppColors.dark.icon
                      : AppColors.light.icon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _destinationFocusNode.dispose();
    super.dispose();
  }
}

// Separate stateless widget for drag handle (better performance)
class _DragHandle extends StatelessWidget {
  final bool isDarkMode;

  const _DragHandle({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingSmall),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppColors.dark.mediumGrayColor
                : AppColors.light.mediumGrayColor,
            borderRadius: BorderRadius.circular(AppSizes.fullBorderRadius),
          ),
        ),
      ),
    );
  }
}

// Separate stateless widget for search input (better performance)
class _SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isDarkMode;

  const _SearchInput({
    required this.controller,
    required this.focusNode,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.dark.darkSurfaceComplimentColor
            : AppColors.light.lightGrayColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: AppTextStyles.bodyStyle(
          isDarkMode: isDarkMode,
          fontSize: AppSizes.fontSizeMedium,
        ),
        decoration: InputDecoration(
          hintText: 'Where is your parcel going?',
          hintStyle: AppTextStyles.bodyStyle(
            isDarkMode: isDarkMode,
            color: isDarkMode
                ? AppColors.dark.mediumGrayColor
                : AppColors.light.mediumGrayColor,
            fontSize: AppSizes.fontSizeMedium,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: isDarkMode
                  ? AppColors.dark.mediumGrayColor
                  : AppColors.light.mediumGrayColor,
              size: AppSizes.iconSizeMedium,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingMedium,
          ),
        ),
      ),
    );
  }
}
