import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/signin_with_phone_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/x_state/state.dart';
import 'package:whatsapp/generated/l10n.dart';

final authViewmodelProvider = Provider.autoDispose((ref) {
  return AuthViewmodel(
    signInWithPhoneUseCase: ref.watch(signInWithPhoneUseCaseProvider),
    verifyOTPUseCase: ref.watch(verifyOTPUseCaseProvider),
    ref: ref,
  );
});

final countryPickerProvider = StateProvider<Country?>((ref) => null);

class AuthViewmodel with BaseAuthViewmodel {
  AuthViewmodel({required this.verifyOTPUseCase, required this.ref, required this.signInWithPhoneUseCase});
  Ref ref;
  final SignInWithPhoneUseCase signInWithPhoneUseCase;
  final VerifyOTPUseCase verifyOTPUseCase;
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
  }

  @override
  Future<RemoteObjectState<void>?> sendPhoneNumber() async {
    String phoneNumber = phoneController.text;
    final country = ref.read(countryPickerProvider.notifier).state;

    if (country != null && phoneNumber.isNotEmpty) {
      final result = await signInWithPhoneUseCase('+${country.phoneCode}$phoneNumber');
      return result.fold((failure) {
        return RemoteObjectState.error(S.current.somethingWentWrong);
      }, (success) {
        return const RemoteObjectState.data(true);
      });
    } else if (country == null && phoneNumber.isNotEmpty) {
      showSnackBar(content: 'Please pick a Country');
    } else if (country != null && phoneNumber.isEmpty) {
      showSnackBar(content: 'Please Enter your phone number');
    } else {
      showSnackBar(content: 'Fill out all the fields!');
    }
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
        Navigator.of(context).pushNamed(Routes.navigationMainScreen);
      },
    );
  }
}

abstract class BaseAuthViewmodel {
  void pickCountry(BuildContext context);
  Future<RemoteObjectState<void>?> sendPhoneNumber();
  void dispose();
  void verifyOTP(BuildContext context, String userOTP);
}
