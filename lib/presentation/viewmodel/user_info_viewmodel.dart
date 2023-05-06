import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/data/repository/user_info_repository.dart';

import '../../domain/entities/user_entities.dart';

final userInfoViewmodelProvider = StateProvider((ref) {
  return UserInfoViewmodel(ref.watch(userInfoRepositoryProvider), ref);
});

final userInfoProvider = FutureProvider((ref) async {
  return await ref.watch(userInfoViewmodelProvider).getCurrentUserData();
});

class UserInfoViewmodel implements UserInfoViewmodelBase {
  UserInfoViewmodel(this.userInfoRepositoryProvider, this.ref);
  final UserInfoRepository userInfoRepositoryProvider;
  final Ref ref;
  @override
  void saveUserInfoToFirebase({required String name, required File? profilePic, required BuildContext context}) {
    userInfoRepositoryProvider.saveUserInfoToFirebase(name: name, profilePic: profilePic, ref: ref, context: context);
  }

  @override
  Stream<UserInfo> getUserById(String id) {
    return userInfoRepositoryProvider.getUserData(id);
  }

  @override
  Future<UserInfo>? getCurrentUserData() async {
    return await userInfoRepositoryProvider.getCurrentUserData();
  }
}

abstract class UserInfoViewmodelBase {
  void saveUserInfoToFirebase({required String name, required File? profilePic, required BuildContext context});
  Future<UserInfo>? getCurrentUserData();
  Stream<UserInfo> getUserById(String id);
}
