import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/cache/app_shared_prefs.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

final authLocalDataSourceProvider =
    Provider((ref) => AuthLocalDataSource(sharedPreferences: ref.watch(appSharedPreferenceProvider)));

abstract class BaseAuthLocalDataSource {
  Future<void> setUserLoggedIn(String uid);

  Future<void> removeUser(String uid);

  String? getUser();
}

class AuthLocalDataSource extends BaseAuthLocalDataSource {
  final AppSharedPreferences sharedPreferences;

  AuthLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> setUserLoggedIn(String uid) {
    try {
      return sharedPreferences.setUserLoggedIn(uid);
    } catch (e) {
      throw CachedException(e.toString());
    }
  }

  @override
  Future<void> removeUser(String uid) {
    try {
      return sharedPreferences.removeUser(uid);
    } catch (e) {
      throw CachedException(e.toString());
    }
  }

  @override
  String? getUser() {
    try {
      return sharedPreferences.getUser();
    } catch (e) {
      throw CachedException(e.toString());
    }
  }
}
