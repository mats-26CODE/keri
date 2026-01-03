# Keri Apps Setup Summary

## Overview

Both **Keri** (Client App) and **Keri Driver** (Driver App) have been set up with a scalable Flutter architecture using Riverpod for state management.

## Project Structure

```
keri/ (or keri_driver/)
├── lib/
│   ├── core/
│   │   ├── config/
│   │   │   ├── app_constants.dart       # App-wide constants
│   │   │   └── supabase_config.dart     # Supabase initialization
│   │   ├── providers/
│   │   │   └── app_providers.dart       # Riverpod providers
│   │   ├── routing/
│   │   │   └── app_router.dart          # Route definitions
│   │   ├── theme/
│   │   │   └── app_theme.dart           # Light & Dark themes
│   │   ├── utils/
│   │   │   └── app_text_styles.dart     # Text style helpers
│   │   └── values/
│   │       ├── app_colors.dart          # Color definitions
│   │       └── app_sizes.dart           # Size constants
│   ├── shared/
│   │   └── widgets/
│   │       ├── animations/
│   │       │   └── scale_animation_tap_wrapper.dart
│   │       ├── buttons/
│   │       │   ├── app_button.dart
│   │       │   └── app_icon_button.dart
│   │       ├── inputs/
│   │       │   └── app_input.dart
│   │       ├── bottom_sheets/
│   │       │   └── app_bottom_sheet.dart
│   │       └── loading/
│   │           └── loading_spinner.dart
│   ├── features/
│   │   └── auth/
│   │       └── presentation/
│   │           └── pages/
│   │               └── splash_page.dart
│   └── main.dart
├── pubspec.yaml
└── .env (to be created)
```

## Dependencies Installed

- **State Management**: `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`
- **Backend**: `supabase_flutter`
- **Networking**: `dio`
- **Maps & Location**: `google_maps_flutter`, `geolocator`, `flutter_polyline_points`
- **Notifications**: `firebase_messaging`, `firebase_core`
- **Utils**: `intl`, `flutter_dotenv`, `flutter_secure_storage`
- **UI**: `modal_bottom_sheet`

## Key Components Created

### Core Configuration

1. **AppColors** - Comprehensive color system with light/dark theme support
2. **AppSizes** - Consistent sizing constants
3. **AppTheme** - Material 3 theme with light/dark modes
4. **AppTextStyles** - Typography helpers
5. **AppConstants** - App-wide constants and keys
6. **SupabaseConfig** - Supabase initialization

### Shared Widgets

1. **AppButton** - Customizable button with gradient, outlined variants
2. **AppInput** - Text input with error handling and styling
3. **AppIconButton** - Circular icon button
4. **AppBottomSheet** - Modal bottom sheet component
5. **LoadingSpinner** - Loading indicator
6. **ScaleAnimationTapWrapper** - Tap animation wrapper

### Providers

- `supabaseClientProvider` - Supabase client provider
- `authStateProvider` - Authentication state stream

## Next Steps

### 1. Environment Setup

Create a `.env` file in the root of each app:

```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 2. Authentication Flow

- Create onboarding screens
- Implement phone authentication
- Set up OTP verification
- Create registration flows for different user types

### 3. Feature Development

- Implement feature-based architecture
- Create repositories for data access
- Set up models for data structures
- Implement business logic in providers

### 4. Routing

- Set up navigation (go_router or similar)
- Define route guards for authentication
- Implement deep linking

## Notes

- Both apps share the same core structure and components
- Components are adapted from tcb-popote-mobile but use Riverpod instead of GetX
- All components use functional widgets and arrow functions as per requirements
- The structure is scalable and ready for feature-based development
- Theme supports both light and dark modes
- All shared components are in the `shared/widgets` directory for reusability
