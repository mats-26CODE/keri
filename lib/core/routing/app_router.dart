import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/registration/registration_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegistrationPage());
      case '/home':
        // TODO: Create home page
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Home Page - Coming Soon')),
          ),
        );
      // Add more routes as needed
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
