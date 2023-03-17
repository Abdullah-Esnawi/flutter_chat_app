import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/resources/app_navigator.dart';
import 'package:whatsapp/data/auth/repository/auth_repository.dart';
import 'package:whatsapp/presentation/base/base_viewmodel.dart';
import 'package:whatsapp/presentation/common/widgets/snackbar.dart';

final authViewmodelProvider = Provider((ref) {
  return AuthViewmodel(authRepository: ref.watch(authRepositoryProvider), ref: ref);
});

final countryPickerProvider = StateProvider<Country?>((ref) => null);

class AuthViewmodel with BaseAuthViewmodel {
  AuthViewmodel({required this.ref, required this.authRepository});
  Ref ref;
  final AuthRepository authRepository;
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
  }

  @override
  void sendPhoneNumber() {
    String phoneNumber = phoneController.text;
    final country = ref.read(countryPickerProvider.state).state;

    if (country != null && phoneNumber.isNotEmpty) {
      authRepository.signInWithPhone('+${country.phoneCode}$phoneNumber', AppNavigator.globalContext);
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
      onSelect: (Country country) {
        ref.read(countryPickerProvider.state).state = country;
      },
    );
  }

  @override
  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(context: context, verificationId: verificationId, userOTP: userOTP);
  }
}

abstract class BaseAuthViewmodel {
  void pickCountry(BuildContext context);
  void sendPhoneNumber();
  void dispose();
  void verifyOTP(BuildContext context, String verificationId, String userOTP);
}
