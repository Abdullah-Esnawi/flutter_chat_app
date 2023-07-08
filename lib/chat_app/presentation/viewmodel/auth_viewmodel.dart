import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/set_user_state_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/signin_with_phone_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/x_state/state.dart';

final authViewmodelProvider = Provider.autoDispose((ref) {
  return AuthViewmodel(
    signInWithPhoneUseCase: ref.watch(signInWithPhoneUseCaseProvider),
    verifyOTPUseCase: ref.watch(verifyOTPUseCaseProvider),
    ref: ref,
    setUserStateUseCase: ref.watch(setUserStateUseCaseProvider),
  );
});

final countryPickerProvider = StateProvider<Country?>((ref) => null);

class AuthViewmodel with BaseAuthViewmodel {
  AuthViewmodel({
    required this.setUserStateUseCase,
    required this.verifyOTPUseCase,
    required this.ref,
    required this.signInWithPhoneUseCase,
  });
  final Ref ref;
  final SignInWithPhoneUseCase signInWithPhoneUseCase;
  final VerifyOTPUseCase verifyOTPUseCase;
  final SetUserStateUseCase setUserStateUseCase;

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
      final result = await signInWithPhoneUseCase('+${country.phoneCode}$phoneNumber');
      return result.fold((failure) {
        return RemoteObjectState.error(failure.message);
      }, (user) {
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
  Future<void> verifyOTP(BuildContext context, String userOTP) async {
    final result = await verifyOTPUseCase(VerifyOTPParams(
      context: context,
      userOTP: userOTP,
      phone: phoneController.text,
    ));

    result.fold(
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
}

abstract class BaseAuthViewmodel {
  void pickCountry(BuildContext context);
  Future<RemoteObjectState<void>> sendPhoneNumber();
  void dispose();
  void verifyOTP(BuildContext context, String userOTP);
  Future<RemoteObjectState<void>> setUserState(bool isOnline);
}
