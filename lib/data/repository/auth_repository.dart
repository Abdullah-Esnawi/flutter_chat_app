import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/presentation/common/widgets/snackbar.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.firebaseAuth, required this.firestore});

  void signInWithPhone(String phoneNumber, BuildContext context) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (err) {
          if (err.code == 'invalid-phone-number') {
            showSnackBar(content: " The provided phone number is not valid.");
          } else {
            showSnackBar(content: "verification failed with unknown error ");
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.pushNamed(context, Routes.OTPScreen, arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (err) {
      showSnackBar(content: err.toString());
    }
  }

  void verifyOTP({required BuildContext context, required String verificationId, required String userOTP, required String phone}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOTP);
      await firebaseAuth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(context, Routes.userInfoScreen, (route) => false, arguments:phone );
    } on FirebaseAuthException catch (err) {
      showSnackBar(content: err.message!);
    }
  }
}
