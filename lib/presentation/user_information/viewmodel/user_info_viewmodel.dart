import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/data/user_info/repository/user_info_repository.dart';
import 'package:whatsapp/domain/user_info/entity/user_model.dart';


final userInfoViewmodelProvider = StateProvider((ref) {
  return UserInfoViewmodel(ref.watch(userInfoRepositoryProvider), ref);
});

final userInfoProvider = FutureProvider((ref) {
  return ref.watch(userInfoViewmodelProvider).getCurrentUserData();
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
  UserInfo? getCurrentUserData() {
    userInfoRepositoryProvider.getCurrentUserData();
    return null;
  }
}

abstract class UserInfoViewmodelBase {
  void saveUserInfoToFirebase({required String name, required File? profilePic, required BuildContext context});
  UserInfo? getCurrentUserData();
}
