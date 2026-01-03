import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/registration_data.dart';

/// Provider for managing registration data
class RegistrationNotifier extends StateNotifier<RegistrationData> {
  RegistrationNotifier() : super(RegistrationData());

  void setPhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  void setUserRole(UserRole role) {
    state = state.copyWith(userRole: role);
  }

  void setOtp(String otp) {
    state = state.copyWith(otp: otp);
  }

  void setPersonalDetails({String? username, String? email, String? fullName}) {
    state = state.copyWith(
      username: username,
      email: email,
      fullName: fullName,
    );
  }

  void setBusinessDetails({
    String? businessName,
    String? businessEmail,
    String? businessPhone,
    String? tinNumber,
    String? businessCategory,
    String? shortDescription,
  }) {
    state = state.copyWith(
      businessName: businessName,
      businessEmail: businessEmail,
      businessPhone: businessPhone,
      tinNumber: tinNumber,
      businessCategory: businessCategory,
      shortDescription: shortDescription,
    );
  }

  void setLocation({
    required double latitude,
    required double longitude,
    String? locationName,
  }) {
    state = state.copyWith(
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
    );
  }

  void reset() {
    state = RegistrationData();
  }
}

final registrationProvider =
    StateNotifierProvider<RegistrationNotifier, RegistrationData>((ref) {
      return RegistrationNotifier();
    });

/// Provider for managing registration step
class RegistrationStepNotifier extends StateNotifier<int> {
  RegistrationStepNotifier() : super(0);

  void nextStep() {
    state++;
  }

  void previousStep() {
    if (state > 0) {
      state--;
    }
  }

  void goToStep(int step) {
    state = step;
  }

  void reset() {
    state = 0;
  }
}

final registrationStepProvider =
    StateNotifierProvider<RegistrationStepNotifier, int>((ref) {
      return RegistrationStepNotifier();
    });
