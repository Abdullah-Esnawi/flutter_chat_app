import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final currentLanguage =   StateProvider((ref) => 'en');

final appSharedPreferenceProvider = Provider<AppSharedPreferences>((ref) {
  return AppSharedPreferences();
});

enum AppLanguages { en, ar }

class AppSharedPreferences {
  AppSharedPreferences();
  static const _selectedLanguageKey = "_selectedLanguageKey";

  // late SharedPreferences _sharedPreferences;

  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

    Future<void> setLang(String lang) async {
    var instance = await SharedPreferences.getInstance();
    instance.setString(_selectedLanguageKey, lang);
  }

    Future<String> getCurrentLang() async {
    var instance = await SharedPreferences.getInstance();
    return instance.getString(_selectedLanguageKey) ?? 'en';
  }
}
