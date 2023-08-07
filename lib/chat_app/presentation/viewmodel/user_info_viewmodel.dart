// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:whatsapp/chat_app/data/data_source/notifications/notification_config.dart';
// import 'package:whatsapp/chat_app/data/repository/user_info_repository.dart';
// import 'package:whatsapp/chat_app/domain/usecases/auth/save_user_data_use_case.dart';
// import 'package:whatsapp/chat_app/presentation/view/main_navigations/main_navigation_screen.dart';
// import 'package:whatsapp/core/resources/widgets/snackbar.dart';

// import '../../domain/entities/user_entity.dart';

// final userInfoViewmodelProvider = StateProvider((ref) {
//   return UserInfoViewmodel(ref.watch(userInfoRepositoryProvider), ref, ref.watch(saveUserDataUseCaseProvider),
//       ref.watch(notificationsConfigProvider));
// });


// class UserInfoViewmodel implements UserInfoViewmodelBase {
//   UserInfoViewmodel(this.ref, this._setUserStateUseCaseProvider, this._notificationsConfig);
//   // final UserInfoRepository userInfoRepositoryProvider;
//   final SaveUserDataToFirebaseUseCase _setUserStateUseCaseProvider;
//   final NotificationsConfig _notificationsConfig;
//   final Ref ref;

//   @override
//   Future<void> saveUserInfoToFirebase(
//       {required String name, required File? profilePic, required BuildContext context}) async {
//     var token = await _notificationsConfig.getToken();
//     final result =
//         await _setUserStateUseCaseProvider(UserDataParams(name: name, profilePic: profilePic, pushToken: token));

//     result.fold(
//       (fail) {
//         showSnackBar(content: 'Data isn\'t Updated');
//         debugPrint("ERREREEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
//       },
//       (success) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
//           (route) => false,
//         );
//         showSnackBar(content: 'Data Updated Successfully');
//       },
//     );
//   }

//   @override
//   Stream<UserInfoEntity> getUserById(String id) {
//     return userInfoRepositoryProvider.getUserData(id);
//   }

//   @override
//   Future<UserInfoEntity?> getCurrentUserData() async {
//     return await userInfoRepositoryProvider.getCurrentUserData();
//   }
// }

// abstract class UserInfoViewmodelBase {
//   Future<void> saveUserInfoToFirebase({required String name, required File? profilePic, required BuildContext context});
//   Future<UserInfoEntity?> getCurrentUserData();
//   Stream<UserInfoEntity> getUserById(String id);
// }
