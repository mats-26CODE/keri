import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationState {
  final LatLng? currentLocation;
  final LatLng? selectedLocation;
  final String? locationName;
  final bool hasPermission;
  final bool isLoading;
  final String? error;

  LocationState({
    this.currentLocation,
    this.selectedLocation,
    this.locationName,
    this.hasPermission = false,
    this.isLoading = false,
    this.error,
  });

  LocationState copyWith({
    LatLng? currentLocation,
    LatLng? selectedLocation,
    String? locationName,
    bool? hasPermission,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      currentLocation: currentLocation ?? this.currentLocation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      locationName: locationName ?? this.locationName,
      hasPermission: hasPermission ?? this.hasPermission,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(LocationState());

  Future<void> checkLocationPermission() async {
    state = state.copyWith(isLoading: true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        state = state.copyWith(
          hasPermission: false,
          isLoading: false,
          error: 'Location permission denied',
        );
        return;
      }

      state = state.copyWith(hasPermission: true);
      await getCurrentLocation();
    } catch (e) {
      state = state.copyWith(
        hasPermission: false,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      state = state.copyWith(isLoading: true);

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final location = LatLng(position.latitude, position.longitude);

      state = state.copyWith(
        currentLocation: location,
        selectedLocation: location,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateSelectedLocation(LatLng location, String? locationName) {
    state = state.copyWith(
      selectedLocation: location,
      locationName: locationName,
    );
  }

  Future<void> getAddressFromLocation(LatLng location) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = [
          if (place.street != null && place.street!.isNotEmpty) place.street,
          if (place.subLocality != null && place.subLocality!.isNotEmpty)
            place.subLocality,
          if (place.locality != null && place.locality!.isNotEmpty)
            place.locality,
        ].join(', ');

        state = state.copyWith(
          selectedLocation: location,
          locationName: address.isNotEmpty ? address : null,
        );
      }
    } catch (e) {
      // If geocoding fails, just update the location without the name
      state = state.copyWith(selectedLocation: location);
    }
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) {
    return LocationNotifier();
  },
);
