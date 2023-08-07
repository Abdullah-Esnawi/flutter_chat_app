import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/data/data_source/notifications/notification_config.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/get_user_by_id_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/save_user_data_use_case.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/set_user_state_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/signin_with_phone_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/signout_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:whatsapp/chat_app/presentation/view/main_navigations/main_navigation_screen.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';
import 'package:whatsapp/core/x_state/state.dart';

final authViewmodelProvider = Provider((ref) {
  return AuthViewmodel(
      signOutUseCase: ref.watch(signOutUseCaseProvider),
      signInWithPhoneUseCase: ref.watch(signInWithPhoneUseCaseProvider),
      verifyOTPUseCase: ref.watch(verifyOTPUseCaseProvider),
      ref: ref,
      setUserStateUseCase: ref.watch(setUserStateUseCaseProvider),
      getCurrentUserUseCase: ref.watch(getCurrentUserUseCaseProvider),
      getUserByIdUseCase: ref.watch(getUserByIdUseCaseProvider),
      notificationsConfig: ref.watch(notificationsConfigProvider),
      saveUserDataToFirebase: ref.watch(saveUserDataUseCaseProvider));
});
final countryPickerProvider = StateProvider<Country?>((ref) => null);

final userInfoProvider = StateProvider<UserInfoEntity?>((ref) {
  return null;
});

class AuthViewmodel with BaseAuthViewmodel {
  AuthViewmodel({
    required this.signOutUseCase,
    required this.setUserStateUseCase,
    required this.verifyOTPUseCase,
    required this.ref,
    required this.signInWithPhoneUseCase,
    required this.getCurrentUserUseCase,
    required this.getUserByIdUseCase,
    required this.notificationsConfig,
    required this.saveUserDataToFirebase,
  });
  final Ref ref;
  final SignInWithPhoneUseCase signInWithPhoneUseCase;
  final VerifyOTPUseCase verifyOTPUseCase;
  final SetUserStateUseCase setUserStateUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final SaveUserDataToFirebaseUseCase saveUserDataToFirebase;
  final NotificationsConfig notificationsConfig;
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
  }

  @override
  Future<RemoteObjectState<UserInfoEntity?>> sendPhoneNumber() async {
    String phoneNumber = phoneController.text;
    // var state = const RemoteObjectState.loading();
    final country = ref.read(countryPickerProvider.notifier).state;

    if (country != null && phoneNumber.isNotEmpty) {
      final result = await signInWithPhoneUseCase('+${country.phoneCode}${phoneNumber.replaceAll(' ', '')}');
      return result.fold((failure) {
        return RemoteObjectState.error(failure.message);
      }, (user) {
        // ref.read(userInfoProvider.notifier).update((state) => user);
        return RemoteObjectState.data(user);
      });
    } else if (country == null && phoneNumber.isNotEmpty) {
      showSnackBar(content: 'Please pick a Country');
    } else if (country != null && phoneNumber.isEmpty) {
      showSnackBar(content: 'Please Enter your phone number');
    } else {
      showSnackBar(content: 'Fill out all the fields!');
    }
    return const RemoteObjectState.loading();
  }

  @override
  void pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      favorite: <String>['EG'],
      onSelect: (Country country) {
        ref.read(countryPickerProvider.notifier).state = country;
      },
    );
  }

  @override
  Stream<UserInfoEntity> getUserById(String id) {
    return getUserByIdUseCase(id);
  }

  @override
  Future<UserInfoEntity?> getCurrentUserData() async {
    final result = await getCurrentUserUseCase(const NoParameters());
    return result.fold(
      (fail) {
        showSnackBar(content: fail.message);
        return null;
      },
      (user) {
        ref.read(userInfoProvider.notifier).update((state) => user);
        return user;
      },
    );
  }

  @override
  Future<void> verifyOTP(BuildContext context, String userOTP) async {
    final result = await verifyOTPUseCase(VerifyOTPParams(
      context: context,
      userOTP: userOTP,
      phone: phoneController.text,
    ));

    return result.fold(
      (err) {
        showSnackBar(content: 'Incorrect OTP Code');
      },
      (success) {
        Navigator.of(context).pushNamed(Routes.userInfoScreen);
        // Navigator.of(context).pushNamedAndRemoveUntil(Routes.navigationMainScreen, (Route<dynamic> route) => false);
      },
    );
  }

  @override
  Future<void> saveUserInfoToFirebase(
      {required String name, required File? profilePic, required BuildContext context}) async {
    var token = await notificationsConfig.getToken();
    final result = await saveUserDataToFirebase(UserDataParams(name: name, profilePic: profilePic, pushToken: token));

    result.fold(
      (fail) {
        showSnackBar(content: 'Data isn\'t Updated');
        debugPrint("ERREREEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      },
      (success) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
          (route) => false,
        );
        showSnackBar(content: 'Data Updated Successfully');
      },
    );
  }

  @override
  Future<RemoteObjectState<void>> setUserState(bool isOnline) async {
    var state = const RemoteObjectState.loading();
    final result = await setUserStateUseCase(isOnline);

    result.fold((failure) {
      state = RemoteObjectState.error(failure.message);
    }, (success) {
      state = const RemoteObjectState.data(true);
    });
    return state;
  }

  @override
  Future<void> logout(BuildContext context) async {
    final result = await signOutUseCase(const NoParameters());
    // ref.read(userInfoProvider.notifier).update((state) => null);
    result.fold(
      (l) => Navigator.pushNamedAndRemoveUntil(context, Routes.privacy, (route) => false),
      (r) => Navigator.pushNamedAndRemoveUntil(context, Routes.privacy, (route) => false),
    );
  }
}

abstract class BaseAuthViewmodel {
  void pickCountry(BuildContext context);
  Future<RemoteObjectState<void>> sendPhoneNumber();
  void dispose();
  void verifyOTP(BuildContext context, String userOTP);
  Future<RemoteObjectState<void>> setUserState(bool isOnline);
  Stream<UserInfoEntity> getUserById(String id);
  Future<UserInfoEntity?> getCurrentUserData();
  Future<void> logout(BuildContext context);
  Future<void> saveUserInfoToFirebase({required String name, required File? profilePic, required BuildContext context});
}
