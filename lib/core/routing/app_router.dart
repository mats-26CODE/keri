import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/registration/registration_page.dart';
import '../../features/home/presentation/pages/navigation_page.dart';

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
        return MaterialPageRoute(builder: (_) => const NavigationPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
