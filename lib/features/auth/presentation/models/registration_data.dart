/// Enum for user registration types
enum UserRole {
  personal,
  business;

  String get name {
    switch (this) {
      case UserRole.personal:
        return 'Personal';
      case UserRole.business:
        return 'Business';
    }
  }

  String get description {
    switch (this) {
      case UserRole.personal:
        return 'For Personal Use';
      case UserRole.business:
        return 'For Business Use';
    }
  }
}

/// Model for registration data
class RegistrationData {
  // Common fields
  String? phoneNumber;
  UserRole? userRole;
  String? otp;

  // Personal user fields
  String? username;
  String? email;
  String? fullName;

  // Business user fields
  String? businessName;
  String? businessEmail;
  String? businessPhone;
  String? tinNumber;
  String? businessCategory;
  String? shortDescription;
  double? latitude;
  double? longitude;
  String? locationName;

  RegistrationData({
    this.phoneNumber,
    this.userRole,
    this.otp,
    this.username,
    this.email,
    this.fullName,
    this.businessName,
    this.businessEmail,
    this.businessPhone,
    this.tinNumber,
    this.businessCategory,
    this.shortDescription,
    this.latitude,
    this.longitude,
    this.locationName,
  });

  RegistrationData copyWith({
    String? phoneNumber,
    UserRole? userRole,
    String? otp,
    String? username,
    String? email,
    String? fullName,
    String? businessName,
    String? businessEmail,
    String? businessPhone,
    String? tinNumber,
    String? businessCategory,
    String? shortDescription,
    double? latitude,
    double? longitude,
    String? locationName,
  }) {
    return RegistrationData(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userRole: userRole ?? this.userRole,
      otp: otp ?? this.otp,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      businessName: businessName ?? this.businessName,
      businessEmail: businessEmail ?? this.businessEmail,
      businessPhone: businessPhone ?? this.businessPhone,
      tinNumber: tinNumber ?? this.tinNumber,
      businessCategory: businessCategory ?? this.businessCategory,
      shortDescription: shortDescription ?? this.shortDescription,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
    );
  }
}
