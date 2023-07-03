import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/data/models/user_model.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/save_user_data_use_case.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/signin_with_phone_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/verify_otp_usecase.dart';

abstract class BaseAuthRemoteDataSource {
  Future<void> signInWithPhoneNumber(String phone);

  Future<void> verifyOtp(VerifyOTPParams parameters);

  Future<void> saveUserDataToFirebase(UserDataParams parameters);

  Future<String> get getCurrentUid;

  Future<void> signOut();

  Future<UserInfoModel> getCurrentUser();

  Stream<UserInfoModel> getUserById(String uId);

  Future<void> setUserState(bool isOnline);
  Future<void> updateProfilePic(String path);
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  String _verificationId = '';

  AuthRemoteDataSource({
    required this.auth,
    required this.firestore,
    required this.firebaseStorage,
  });

  @override
  Future<String> get getCurrentUid async => auth.currentUser!.uid;

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> signInWithPhoneNumber(String phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (AuthCredential credential) async {
        await auth.signInWithCredential(credential);

        debugPrint("phone verified : Token ${credential.token}");
      },
      verificationFailed: (e) {
        throw Exception(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint("time out :$verificationId");
      },
      timeout: const Duration(minutes: 1),
    );
  }

  @override
  Future<void> verifyOtp(VerifyOTPParams parameters) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: parameters.userOTP,
    );
    await auth.signInWithCredential(credential);
  }

  @override
  Future<void> saveUserDataToFirebase(UserDataParams parameters) async {
    String uId = await getCurrentUid;

    String photoUrl = '';
    if (parameters.profilePic != null) {
      photoUrl = await _storeFileToFirebase(
        'profilePic/$uId',
        parameters.profilePic!,
      );
    }

    var user = UserInfoModel(
      name: parameters.name,
      uid: uId,
      status: 'AppStrings.heyThere', ///////
      profilePic: photoUrl,
      phoneNumber: auth.currentUser!.phoneNumber!,
      isOnline: true,
      groupId: const [],
      lastSeen: DateTime.now(),
    );
    var userDoc = await firestore.collection('users').doc(uId).get();
    if (userDoc.exists) {
      await firestore.collection('users').doc(uId).update(user.toMap());
    } else {
      await firestore.collection('users').doc(uId).set(user.toMap());
    }
  }

  Future<String> _storeFileToFirebase(String path, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _deleteFileFromFirebase(String path) async {
    return await firebaseStorage.refFromURL(path).delete();
  }

  @override
  Future<UserInfoModel> getCurrentUser() async {
    var userData = await firestore.collection('users').doc(await getCurrentUid).get();
    UserInfoModel user = UserInfoModel.fromMap(userData.data()!);
    return user;
  }

  @override
  Stream<UserInfoModel> getUserById(String uId) {
    return firestore.collection('users').doc(uId).snapshots().map(
      (event) {
        return UserInfoModel.fromMap(event.data()!);
      },
    );
  }

  @override
  Future<void> setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> updateProfilePic(String path) async {
    String uId = auth.currentUser!.uid;
    //firstly delete previus image
    var userData = await firestore.collection('users').doc(uId).get();
    UserInfoModel user = UserInfoModel.fromMap(userData.data()!);
    if (user.profilePic.isNotEmpty) {
      await _deleteFileFromFirebase(user.profilePic);
    }
    //then upload new image
    String photoUrl = await _storeFileToFirebase(
      'profilePic/$uId',
      File(path),
    );
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'profilePic': photoUrl,
    });
  }
}
