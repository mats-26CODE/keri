class AppConstants {
  // App Info
  static const String appName = 'Keri';
  static const String appVersion = '0.1.0';

  // App External Urls //TODO: Change these to the actual URLs
  static const String appStoreUrl = 'https://apps.apple.com';
  static const String playStoreUrl = 'https://play.google.com';
  static const String websiteUrl = 'https://google.com';
  static const String privacyPolicyUrl = 'https://google.com';
  static const String termsOfServiceUrl = 'https://google.com';
  static const String contactUsUrl = 'https://google.com';
  static const String helpCenterUrl = 'https://google.com';
  static const String feedbackUrl = 'https://google.com';
  static const String aboutUsUrl = 'https://google.com';

  // API & Backend
  static const String supabaseUrlKey = 'SUPABASE_URL';
  static const String supabaseAnonKeyKey = 'SUPABASE_ANON_KEY';

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userRoleKey = 'user_role';
  static const String onboardingCompletedKey = 'onboarding_completed';

  // Routes
  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';

  // User Roles
  static const String roleBusinessClient = 'BusinessClient';
  static const String roleIndividualClient = 'IndividualClient';
  static const String roleDriver = 'Driver';
  static const String roleLogisticCompany = 'LogisticCompany';
  static const String roleAdmin = 'Admin';

  // Toast notification duration (seconds)
  static const int toastAutoCloseDuration = 3;

  // OTP
  static const int otpLength = 6;
}
