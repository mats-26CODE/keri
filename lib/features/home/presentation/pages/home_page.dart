import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keri/shared/widgets/loading/loading_spinner.dart';
import '../../../auth/presentation/providers/location_provider.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_sizes.dart';
import '../../../../shared/widgets/animations/scale_animation_tap_wrapper.dart';
import '../../../../shared/widgets/buttons/app_icon_button.dart';
import '../../../../shared/widgets/profile/app_profile_picture.dart';
import '../widgets/delivery_request_panel.dart';

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
                  child: Center(child: LoadingSpinner()),
                ),

          // Top Right Action Buttons (stacked vertically)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.screenPaddingX),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Profile Picture Button
                  ScaleAnimationTapWrapper(
                    onTap: () {
                      // Navigate to profile or show menu
                    },
                    child: AppProfilePicture(
                      size: AppSizes.iconButtonSize,
                      showEditButton: true,
                      showBorder: true,
                      showShadow: true,
                      enableRotatingBorder: true,
                      borderWidth: 2,
                      alignment: Alignment.centerRight,
                    ),
                  ),

                  const SizedBox(height: AppSizes.spacingSmall),

                  // Navigation/Recenter Button
                  AppIconButton(
                    icon: HugeIcon(icon: HugeIcons.strokeRoundedNavigation03),
                    onPressed: () {
                      if (locationState.currentLocation != null &&
                          _mapController != null) {
                        _mapController!.animateCamera(
                          CameraUpdate.newLatLng(
                            locationState.currentLocation!,
                          ),
                        );
                      }
                    },
                    size: AppSizes.iconButtonSize,
                  ),

                  const SizedBox(height: AppSizes.spacingSmall),

                  // Share Button
                  AppIconButton(
                    icon: HugeIcon(icon: HugeIcons.strokeRoundedShare08),
                    onPressed: () {
                      // Share location
                    },
                    size: AppSizes.iconButtonSize,
                  ),
                ],
              ),
            ),
          ),

          // Delivery Request Panel
          const DeliveryRequestPanel(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
