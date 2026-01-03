import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Storage key
const String _languageStorageKey = 'language_code';

// Secure storage instance
const FlutterSecureStorage _storage = FlutterSecureStorage();

// Supported languages
enum AppLanguage {
  english('en', 'English'),
  swahili('sw', 'Swahili');

  final String code;
  final String name;

  const AppLanguage(this.code, this.name);

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}

// Language notifier
class LanguageNotifier extends StateNotifier<AppLanguage> {
  LanguageNotifier() : super(AppLanguage.english) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    try {
      final savedLanguage = await _storage.read(key: _languageStorageKey);
      if (savedLanguage != null) {
        state = AppLanguage.fromCode(savedLanguage);
      }
    } catch (e) {
      // Fallback to English
      state = AppLanguage.english;
    }
  }

  Future<void> setLanguage(AppLanguage language) async {
    state = language;
    await _storage.write(key: _languageStorageKey, value: language.code);
  }
}

// Language provider
final languageProvider = StateNotifierProvider<LanguageNotifier, AppLanguage>(
  (ref) => LanguageNotifier(),
);
