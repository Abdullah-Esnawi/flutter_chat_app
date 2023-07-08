import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/data/repository/user_info_repository.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/save_user_data_use_case.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';

import '../../domain/entities/user_entity.dart';

final userInfoViewmodelProvider = StateProvider((ref) {
  return UserInfoViewmodel(
    ref.watch(userInfoRepositoryProvider),
    ref,
    ref.watch(saveUserDataUseCaseProvider),
  );
});

final userInfoProvider = FutureProvider<UserInfoEntity?>((ref) async {
  return await ref.watch(userInfoViewmodelProvider).getCurrentUserData();
});

class UserInfoViewmodel implements UserInfoViewmodelBase {
  UserInfoViewmodel(this.userInfoRepositoryProvider, this.ref, this._setUserStateUseCaseProvider);
  final UserInfoRepository userInfoRepositoryProvider;
  final SaveUserDataToFirebaseUseCase _setUserStateUseCaseProvider;
  final Ref ref;

  @override
  Future<void> saveUserInfoToFirebase({required String name, required File? profilePic}) async {
    final result = await _setUserStateUseCaseProvider(UserDataParams(name: name, profilePic: profilePic));

    result.fold(
      (fail) {
        showSnackBar(content: 'Data isn\'t Updated');
      },
      (success) {
        showSnackBar(content: 'Data Updated Successfully');
      },
    );
  }

  @override
  Stream<UserInfoEntity> getUserById(String id) {
    return userInfoRepositoryProvider.getUserData(id);
  }

  @override
  Future<UserInfoEntity?> getCurrentUserData() async {
    return await userInfoRepositoryProvider.getCurrentUserData();
  }
}

abstract class UserInfoViewmodelBase {
  void saveUserInfoToFirebase({required String name, required File? profilePic});
  Future<UserInfoEntity?> getCurrentUserData();
  Stream<UserInfoEntity> getUserById(String id);
}
