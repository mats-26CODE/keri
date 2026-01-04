import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keri/shared/widgets/loading/loading_spinner.dart';
import '../../../../../../core/values/app_colors.dart';
import '../../../../../../core/values/app_sizes.dart';
import '../../../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../../../shared/widgets/animations/slide_fade_in_animation.dart';
import '../../../../../../shared/widgets/inputs/app_input.dart';
import '../../../../../../shared/widgets/buttons/app_button.dart';
import '../../../providers/location_provider.dart';

class LocationSelectionStep extends ConsumerStatefulWidget {
  const LocationSelectionStep({super.key});

  @override
  ConsumerState<LocationSelectionStep> createState() =>
      _LocationSelectionStepState();
}

class _LocationSelectionStepState extends ConsumerState<LocationSelectionStep> {
  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng? _currentMapCenter;
  bool _isUserTyping = false;

  @override
  void initState() {
    super.initState();
    // Check location permission when entering the step
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationProvider.notifier).checkLocationPermission();
    });

    // Listen to search controller changes to detect user typing
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        setState(() {
          _isUserTyping = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapCenter = position.target;
    // Mark as not user typing when map is being dragged
    if (_isUserTyping) {
      setState(() {
        _isUserTyping = false;
      });
    }
  }

  void _onCameraIdle() async {
    if (_currentMapCenter != null) {
      // Get address from coordinates
      await ref
          .read(locationProvider.notifier)
          .getAddressFromLocation(_currentMapCenter!);

      // Update search controller with the address if user is not typing
      if (!_isUserTyping) {
        final locationState = ref.read(locationProvider);
        if (locationState.locationName != null) {
          _searchController.text = locationState.locationName!;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final locationState = ref.watch(locationProvider);
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingX),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSizes.spacingMedium),

          // Title
          SlideFadeInAnimation(
            duration: const Duration(milliseconds: 300),
            delay: const Duration(milliseconds: 100),
            beginOffset: const Offset(0, 0.1),
            child: FadeInText.heading(
              text: "Great. Now let's set up your business location",
              fontSize: AppSizes.fontSizeTitleXXLarge,
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 100),
            ),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          if (locationState.hasPermission) ...[
            SlideFadeInAnimation(
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 150),
              beginOffset: const Offset(0, 0.1),
              child: FadeInText.body(
                text: '*Drag the map to accurately set your location',
              ),
            ),
            const SizedBox(height: AppSizes.spacingMedium),
          ],

          // Map or Permission Request View - Flexible space that shrinks with keyboard
          Flexible(
            flex: keyboardVisible ? 2 : 3,
            child: locationState.hasPermission
                ? _buildMapView(isDarkMode, locationState)
                : _buildPermissionView(isDarkMode, locationState),
          ),

          // Spacing that shrinks when keyboard appears
          SizedBox(
            height: keyboardVisible
                ? AppSizes.spacingSmall
                : AppSizes.spacingLarge,
          ),

          // Search Input (only show when permission granted)
          if (locationState.hasPermission) ...[
            AppInput(
              controller: _searchController,
              keyboardType: TextInputType.text,
              labelText: 'Location Address',
              hintText: 'Search or drag map to set location',
              onChanged: (value) {
                setState(() {
                  _isUserTyping = true;
                });
                // Update location name when user types
                if (_currentMapCenter != null) {
                  ref
                      .read(locationProvider.notifier)
                      .updateSelectedLocation(_currentMapCenter!, value.trim());
                }
              },
              prefixIcon: const Padding(
                padding: EdgeInsets.all(12.0),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  size: AppSizes.iconSizeMedium,
                ),
              ),
            ),
            SizedBox(height: AppSizes.spacingLarge),
          ],
        ],
      ),
    );
  }

  Widget _buildMapView(bool isDarkMode, LocationState locationState) {
    if (locationState.isLoading || locationState.currentLocation == null) {
      return Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColors.dark.darkSurfaceGrayColor
              : AppColors.light.lightGrayColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingSpinner(size: AppSizes.iconSizeXLarge),
              const SizedBox(height: AppSizes.spacingMedium),
              FadeInText.body(
                text: 'Getting your location...',
                fontSize: AppSizes.fontSizeMedium,
                duration: const Duration(milliseconds: 300),
                delay: const Duration(milliseconds: 100),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: locationState.currentLocation!,
              zoom: 15.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onCameraMove: _onCameraMove,
            onCameraIdle: _onCameraIdle,
            mapType: MapType.normal,
          ),
          // Center Pin
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedPinLocation03,
                  size: 48,
                  color: isDarkMode
                      ? AppColors.dark.primaryColor
                      : AppColors.light.primaryColor,
                ),
                const SizedBox(height: 48), // Offset to center the pin tip
              ],
            ),
          ),
          // My Location Button
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: isDarkMode
                  ? AppColors.dark.background
                  : AppColors.light.background,
              onPressed: () {
                if (locationState.currentLocation != null) {
                  _mapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: locationState.currentLocation!,
                        zoom: 15.0,
                      ),
                    ),
                  );
                }
              },
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedNavigation03,
                size: 20,
                color: isDarkMode
                    ? AppColors.dark.primaryColor
                    : AppColors.light.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionView(bool isDarkMode, LocationState locationState) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacingLarge),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.dark.primaryColor.withAlpha(10)
            : AppColors.light.primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(AppSizes.cardXLargeBorderRadius),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedLocation08,
              size: 64,
              color: isDarkMode
                  ? AppColors.dark.errorColor
                  : AppColors.light.errorColor,
            ),
            const SizedBox(height: AppSizes.spacingLarge),
            FadeInText.heading(
              text: 'Location Permission Required',
              fontSize: AppSizes.fontSizeLarge,
              textAlign: TextAlign.center,
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 100),
            ),
            const SizedBox(height: AppSizes.spacingSmall),
            FadeInText.body(
              text:
                  'We need your location to set up your business address and show nearby delivery options.',
              fontSize: AppSizes.fontSizeMedium,
              textAlign: TextAlign.center,
              duration: const Duration(milliseconds: 300),
              delay: const Duration(milliseconds: 150),
            ),
            const SizedBox(height: AppSizes.spacingXLarge),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Grant Permission',
                    onPressed: () => ref
                        .read(locationProvider.notifier)
                        .checkLocationPermission(),
                  ),
                ),
                const SizedBox(width: AppSizes.spacingSmall),
                Expanded(
                  child: AppButton(
                    text: 'Settings',
                    onPressed: () =>
                        ref.read(locationProvider.notifier).openAppSettings(),
                    backgroundColor: isDarkMode
                        ? AppColors.dark.darkSurfaceComplimentColor
                        : AppColors.light.lightGrayColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
