import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../auth/presentation/providers/location_provider.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_sizes.dart';
import '../widgets/delivery_request_bottom_sheet.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  // Mock driver locations - replace with real data later
  final List<LatLng> _driverLocations = [
    const LatLng(-6.7924, 39.2083),
    const LatLng(-6.7950, 39.2100),
    const LatLng(-6.7900, 39.2050),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocation();
    });
  }

  Future<void> _initializeLocation() async {
    final locationNotifier = ref.read(locationProvider.notifier);
    await locationNotifier.checkLocationPermission();

    if (ref.read(locationProvider).hasPermission) {
      await locationNotifier.getCurrentLocation();
      _updateMarkers();
    }
  }

  void _updateMarkers() {
    final locationState = ref.read(locationProvider);

    setState(() {
      _markers.clear();

      // Add user location marker
      if (locationState.currentLocation != null) {
        _markers.add(
          Marker(
            markerId: const MarkerId('user_location'),
            position: locationState.currentLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        );
      }

      // Add driver markers
      for (int i = 0; i < _driverLocations.length; i++) {
        _markers.add(
          Marker(
            markerId: MarkerId('driver_$i'),
            position: _driverLocations[i],
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            infoWindow: InfoWindow(title: 'Driver ${i + 1}'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final locationState = ref.watch(locationProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Google Map Background
          locationState.currentLocation != null
              ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: locationState.currentLocation!,
                    zoom: 14,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                    if (isDarkMode) {
                      // Apply dark map style if needed
                      // controller.setMapStyle(darkMapStyle);
                    }
                  },
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                )
              : Container(
                  color: isDarkMode
                      ? AppColors.dark.background
                      : AppColors.light.background,
                  child: const Center(child: CircularProgressIndicator()),
                ),

          // Top Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.screenPaddingX),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile Button
                  Container(
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.dark.darkSurfaceGrayColor.withAlpha(140)
                          : AppColors.light.pureWhiteColor.withAlpha(140),
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(10),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // Navigate to profile or show menu
                        },
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusLarge,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.paddingSmall),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: isDarkMode
                                ? AppColors.dark.primaryColor.withAlpha(120)
                                : AppColors.light.primaryColor.withAlpha(100),
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedUser,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      // Recenter button
                      _buildActionButton(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedNavigator01,
                          size: 20,
                        ),
                        onTap: () {
                          if (locationState.currentLocation != null &&
                              _mapController != null) {
                            _mapController!.animateCamera(
                              CameraUpdate.newLatLng(
                                locationState.currentLocation!,
                              ),
                            );
                          }
                        },
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(width: AppSizes.spacingSmall),
                      // Share button
                      _buildActionButton(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedShare08,
                          size: 20,
                        ),
                        onTap: () {
                          // Share location
                        },
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Draggable Bottom Sheet
          const DeliveryRequestBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required dynamic icon,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.dark.darkSurfaceGrayColor.withAlpha(140)
            : AppColors.light.pureWhiteColor.withAlpha(140),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            child: IconTheme(
              data: IconThemeData(
                color: isDarkMode ? AppColors.dark.icon : AppColors.light.icon,
                size: AppSizes.iconSizeMedium,
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
