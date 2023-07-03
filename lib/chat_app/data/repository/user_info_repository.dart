import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/repositories/firebase_storage_repository.dart';
import 'package:whatsapp/chat_app/data/models/user_model.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';

final userInfoRepositoryProvider =
    Provider((ref) => UserInfoRepository(firebaseAuth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class UserInfoRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  UserInfoRepository({required this.firebaseAuth, required this.firestore});

  void saveUserInfoToFirebase(
      {required String name, File? profilePic, required Ref ref, required BuildContext context}) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      String photoUrl = 'https://png.pngitem.com/pimgs/s/214-2145309_blank-profile-picture-circle-hd-png-download.png';
      if (profilePic != null) {
        photoUrl = await ref.read(commonFirebaseStorageRepoProvider).storeFileToFirebase('profilePic/$uid', profilePic);
      }

      UserInfoModel user = UserInfoModel(
        phoneNumber: firebaseAuth.currentUser!.phoneNumber!,
        groupId: [],
        name: name,
        profilePic: photoUrl,
        uid: uid,
        isOnline: true,
        lastSeen: DateTime.now(),
        status: '',
      );
      await firestore.collection('users').doc(uid).set(user.toMap());
    } catch (err) {
      showSnackBar(content: err.toString());
    }
  }

  Stream<UserInfoModel> getUserData(String id) {
    return firestore.collection('users').doc(id).snapshots().map((event) {
      return UserInfoModel.fromMap(event.data()!);
    });
  }

  Future<UserInfoModel?> getCurrentUserData() async {
    var userData = await firestore.collection('users').doc(firebaseAuth.currentUser?.uid).get();
    var user = userData.data();
    if (user != null) {
      return UserInfoModel.fromMap(user);
    }
    return null;
  }
}
