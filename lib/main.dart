import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/supabase_config.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/providers/theme_provider.dart';
import 'shared/widgets/animations/animated_theme_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  try {
    await SupabaseConfig.initialize();
  } catch (e) {
    debugPrint('Error initializing Supabase: $e');
  }

  runApp(const ProviderScope(child: KeriApp()));
}

class KeriApp extends ConsumerWidget {
  const KeriApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    // Determine the current theme based on themeMode
    ThemeData currentTheme;
    if (themeMode == ThemeMode.dark) {
      currentTheme = AppTheme.darkTheme;
    } else if (themeMode == ThemeMode.light) {
      currentTheme = AppTheme.lightTheme;
    } else {
      // System mode - check platform brightness
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      currentTheme = brightness == Brightness.dark
          ? AppTheme.darkTheme
          : AppTheme.lightTheme;
    }

    return AnimatedThemeWrapper(
      theme: currentTheme,
      child: MaterialApp(
        title: 'Keri',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
