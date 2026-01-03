import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/onboarding_slide.dart';

final onboardingSlidesProvider = Provider<List<OnboardingSlide>>((ref) {
  return const [
    OnboardingSlide(
      title: 'Ready to Send Your Parcel?',
      description: "Sit back, Relax. We'll take care of your delivery",
    ),
    OnboardingSlide(
      title: 'Pick Nearby Delivery Guy',
      description:
          'Choose from a wide range of nearby delivery guys ready to serve you',
    ),
    OnboardingSlide(
      title: 'Send Cargo & Parcels with ease',
      description:
          'The most convenient, reliable & secure way to send your parcels.',
    ),
  ];
});

