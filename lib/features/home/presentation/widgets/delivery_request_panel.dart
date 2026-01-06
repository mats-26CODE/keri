import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keri/shared/widgets/animations/fade_in_text.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_sizes.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../shared/widgets/animations/scale_animation_tap_wrapper.dart';
import '../../../../shared/widgets/buttons/app_button.dart';
import '../../../../shared/widgets/inputs/app_input.dart';

class DeliveryRequestPanel extends ConsumerStatefulWidget {
  const DeliveryRequestPanel({super.key});

  @override
  ConsumerState<DeliveryRequestPanel> createState() =>
      _DeliveryRequestPanelState();
}

class _DeliveryRequestPanelState extends ConsumerState<DeliveryRequestPanel> {
  final PanelController _panelController = PanelController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final FocusNode _pickupFocusNode = FocusNode();
  final FocusNode _dropoffFocusNode = FocusNode();

  bool _isPickupFocused = false;
  bool _isDropoffFocused = false;
  bool _isAnyFieldFocused = false;

  // Mock recent places - replace with actual data
  final List<Map<String, String>> _recentPlaces = [
    {'name': 'Oysterbay Area, Zone 2', 'date': 'September 26, 2024'},
    {'name': 'Masaki, Universal Plaza', 'date': 'September 20, 2024'},
    {'name': 'Mikocheni, Shoppers Plaza', 'date': 'September 15, 2024'},
  ];

  // Mock search results - replace with actual search
  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();

    // Listen to pickup focus changes
    _pickupFocusNode.addListener(() {
      setState(() {
        _isPickupFocused = _pickupFocusNode.hasFocus;
        _updateFocusState();
      });
    });

    // Listen to dropoff focus changes
    _dropoffFocusNode.addListener(() {
      setState(() {
        _isDropoffFocused = _dropoffFocusNode.hasFocus;
        _updateFocusState();
      });
    });

    // Listen to text changes for search
    _pickupController.addListener(_onSearchChanged);
    _dropoffController.addListener(_onSearchChanged);
  }

  void _updateFocusState() {
    final wasAnyFieldFocused = _isAnyFieldFocused;
    _isAnyFieldFocused = _isPickupFocused || _isDropoffFocused;

    // Expand/collapse panel based on focus
    if (_isAnyFieldFocused && !wasAnyFieldFocused) {
      _panelController.open();
    } else if (!_isAnyFieldFocused && wasAnyFieldFocused) {
      _panelController.close();
    }
  }

  void _onSearchChanged() {
    final searchText = _isPickupFocused
        ? _pickupController.text
        : _dropoffController.text;

    if (searchText.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    // Mock search - replace with actual API call to fetch Tanzania locations
    setState(() {
      _searchResults =
          [
                'Dar es Salaam, Tanzania',
                'Kariakoo, Dar es Salaam',
                'Masaki, Dar es Salaam',
                'Mikocheni, Dar es Salaam',
                'Oysterbay, Dar es Salaam',
              ]
              .where(
                (location) =>
                    location.toLowerCase().contains(searchText.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    return SlidingUpPanel(
      controller: _panelController,
      minHeight: screenHeight * 0.40,
      maxHeight: screenHeight * 0.75,
      backdropEnabled: false,
      renderPanelSheet: false,
      parallaxEnabled: true,
      parallaxOffset: 0.3,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSizes.radiusXLarge),
        topRight: Radius.circular(AppSizes.radiusXLarge),
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
          topLeft: Radius.circular(AppSizes.radiusXLarge),
          topRight: Radius.circular(AppSizes.radiusXLarge),
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

          // Fixed Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.screenPaddingX,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.spacingSmall),

                // Title
                FadeInText.title(
                  text: 'Start Your Parcel / Cargo\nDelivery',
                  fontSize: AppSizes.fontSizeTitleLarge,
                  duration: const Duration(milliseconds: 300),
                  delay: const Duration(milliseconds: 100),
                ),

                const SizedBox(height: AppSizes.spacingLarge),

                // Delivery Card with Inputs
                _buildDeliveryCard(isDarkMode),

                const SizedBox(height: AppSizes.spacingLarge),
              ],
            ),
          ),

          // Content (Recent Places or Search Results)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.screenPaddingX,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isAnyFieldFocused && _searchResults.isNotEmpty)
                    ..._buildSearchResults(isDarkMode)
                  else if (!_isAnyFieldFocused)
                    ..._buildRecentPlaces(isDarkMode),
                ],
              ),
            ),
          ),

          // Fixed Footer with Button
          Container(
            padding: const EdgeInsets.all(AppSizes.screenPaddingX),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.dark.darkSurfaceGrayColor
                  : AppColors.light.pureWhiteColor,
              border: Border(
                top: BorderSide(
                  color: isDarkMode
                      ? AppColors.dark.darkBorderColor
                      : AppColors.light.grayishBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: AppButton(
                text: 'Start Delivery',
                onPressed: () {
                  // Handle start delivery
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacingMedium),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.dark.darkSurfaceComplimentColor
            : AppColors.light.veryLightGrayColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(
          width: 1,
          color: isDarkMode
              ? AppColors.dark.grayishBorderColor
              : AppColors.light.grayishBorderColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // Pickup Input
                _buildLocationInput(
                  controller: _pickupController,
                  focusNode: _pickupFocusNode,
                  isFocused: _isPickupFocused,
                  label: 'Pickup',
                  hint: 'Your Current Location',
                  isDarkMode: isDarkMode,
                ),

                const SizedBox(height: AppSizes.spacingSmall),

                // Drop-off Input
                _buildLocationInput(
                  controller: _dropoffController,
                  focusNode: _dropoffFocusNode,
                  isFocused: _isDropoffFocused,
                  label: 'Drop off',
                  hint: 'Where is your Parcel Going?',
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.dark.darkSurfaceComplimentColor
                    : AppColors.light.veryLightGrayColor,
                border: Border(
                  left: BorderSide(
                    width: 1,
                    color: isDarkMode
                        ? AppColors.dark.grayishBorderColor
                        : AppColors.light.grayishBorderColor,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  '>',
                  style: AppTextStyles.bodyStyle(isDarkMode: isDarkMode),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInput({
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isFocused,
    required String label,
    required String hint,
    required bool isDarkMode,
  }) {
    return AppInput(
      controller: controller,
      focusNode: focusNode,
      labelText: label,
      hintText: hint,
      customBackgroundColor: Colors.transparent,
      customEnabledBorderSide: const BorderSide(
        color: Colors.transparent,
        width: 0,
      ),
      customFocusedBorderSide: BorderSide(
        color: isDarkMode
            ? AppColors.dark.primaryColor
            : AppColors.light.primaryColor,
        width: 2,
      ),
      hideBoxShadow: !isFocused,
      customBorderRadius: 0,
      customContentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: AppSizes.spacingTiny,
      ),
      customHeight: AppSizes.inputHeight - 5,
    );
  }

  List<Widget> _buildSearchResults(bool isDarkMode) {
    if (_searchResults.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLarge),
          child: Center(
            child: Text(
              'No results found',
              style: AppTextStyles.bodyStyle(
                isDarkMode: isDarkMode,
                color: isDarkMode
                    ? AppColors.dark.mediumGrayColor
                    : AppColors.light.mediumGrayColor,
              ),
            ),
          ),
        ),
      ];
    }

    return _searchResults.map((location) {
      return ScaleAnimationTapWrapper(
        onTap: () {
          if (_isPickupFocused) {
            _pickupController.text = location;
            _pickupFocusNode.unfocus();
          } else if (_isDropoffFocused) {
            _dropoffController.text = location;
            _dropoffFocusNode.unfocus();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingLarge,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDarkMode
                    ? AppColors.dark.darkBorderColor
                    : AppColors.light.grayishBorderColor,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedMapsLocation01,
                size: AppSizes.iconSizeMedium,
                color: isDarkMode
                    ? AppColors.dark.mediumGrayColor
                    : AppColors.light.mediumGrayColor,
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: Text(
                  location,
                  style: AppTextStyles.bodyStyle(
                    isDarkMode: isDarkMode,
                    fontSize: AppSizes.fontSizeMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildRecentPlaces(bool isDarkMode) {
    return [
      // Section Title
      Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
        child: Text(
          'Recent Places',
          style: AppTextStyles.subtitleStyle(
            isDarkMode: isDarkMode,
            fontSize: AppSizes.fontSizeMedium,
          ),
        ),
      ),

      // Recent Places List
      ..._recentPlaces.map((place) {
        return ScaleAnimationTapWrapper(
          onTap: () {
            // Handle recent place selection
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.dark.darkSurfaceComplimentColor
                  : AppColors.light.lightGrayColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizes.paddingSmall),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.dark.darkSurfaceGrayColor
                        : AppColors.light.pureWhiteColor,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedClock03,
                    size: AppSizes.iconSizeSmall,
                    color: isDarkMode
                        ? AppColors.dark.mediumGrayColor
                        : AppColors.light.mediumGrayColor,
                  ),
                ),
                const SizedBox(width: AppSizes.spacingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place['name']!,
                        style: AppTextStyles.bodyStyle(
                          isDarkMode: isDarkMode,
                          fontSize: AppSizes.fontSizeMedium,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingTiny),
                      Text(
                        place['date']!,
                        style: AppTextStyles.subtitleStyle(
                          isDarkMode: isDarkMode,
                          fontSize: AppSizes.fontSizeSmall,
                          color: isDarkMode
                              ? AppColors.dark.mediumGrayColor
                              : AppColors.light.mediumGrayColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ];
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    _pickupFocusNode.dispose();
    _dropoffFocusNode.dispose();
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
