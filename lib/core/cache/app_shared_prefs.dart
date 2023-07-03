import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appSharedPreferenceProvider = Provider<AppSharedPreferences>((ref) {
  return AppSharedPreferences();
});

class AppSharedPreferences {
  AppSharedPreferences();
  static const _selectedLanguageKey = "_selectedLanguageKey";
  static const _currentUID = "_currentUID";

  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setLang(String lang) async {
    _sharedPreferences.setString(_selectedLanguageKey, lang);
  }

  String? getCurrentLang() {
    return _sharedPreferences.getString(_selectedLanguageKey);
  }

  Future<void> setUserLoggedIn(String uid) {
    return _sharedPreferences.setString(_currentUID, uid);
  }

  Future<void> removeUser(String uid) {
    return _sharedPreferences.remove(uid);
  }

  String? getUser() {
    return _sharedPreferences.getString(_currentUID);
  }
}
