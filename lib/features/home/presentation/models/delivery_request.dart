class DeliveryRequest {
  final double? pickupLatitude;
  final double? pickupLongitude;
  final String? pickupLocationName;
  final double? dropOffLatitude;
  final double? dropOffLongitude;
  final String? dropOffLocationName;
  final String? vehicleType;

  DeliveryRequest({
    this.pickupLatitude,
    this.pickupLongitude,
    this.pickupLocationName,
    this.dropOffLatitude,
    this.dropOffLongitude,
    this.dropOffLocationName,
    this.vehicleType,
  });

  DeliveryRequest copyWith({
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupLocationName,
    double? dropOffLatitude,
    double? dropOffLongitude,
    String? dropOffLocationName,
    String? vehicleType,
  }) {
    return DeliveryRequest(
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      pickupLocationName: pickupLocationName ?? this.pickupLocationName,
      dropOffLatitude: dropOffLatitude ?? this.dropOffLatitude,
      dropOffLongitude: dropOffLongitude ?? this.dropOffLongitude,
      dropOffLocationName: dropOffLocationName ?? this.dropOffLocationName,
      vehicleType: vehicleType ?? this.vehicleType,
    );
  }
}
