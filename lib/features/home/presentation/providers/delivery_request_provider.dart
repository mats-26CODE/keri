import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/delivery_request.dart';

/// Provider for managing delivery request state
class DeliveryRequestNotifier extends StateNotifier<DeliveryRequest> {
  DeliveryRequestNotifier() : super(DeliveryRequest());

  void setPickupLocation({
    required double latitude,
    required double longitude,
    String? locationName,
  }) {
    state = state.copyWith(
      pickupLatitude: latitude,
      pickupLongitude: longitude,
      pickupLocationName: locationName,
    );
  }

  void setDropOffLocation({
    required double latitude,
    required double longitude,
    String? locationName,
  }) {
    state = state.copyWith(
      dropOffLatitude: latitude,
      dropOffLongitude: longitude,
      dropOffLocationName: locationName,
    );
  }

  void setVehicleType(String vehicleType) {
    state = state.copyWith(vehicleType: vehicleType);
  }

  void reset() {
    state = DeliveryRequest();
  }
}

final deliveryRequestProvider =
    StateNotifierProvider<DeliveryRequestNotifier, DeliveryRequest>((ref) {
  return DeliveryRequestNotifier();
});

