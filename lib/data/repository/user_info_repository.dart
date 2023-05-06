
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/repositories/firebase_storage_repository.dart';
import 'package:whatsapp/data/mapper/user_info_mapper.dart';
import 'package:whatsapp/data/models/user_model.dart';
import 'package:whatsapp/domain/entities/user_entities.dart';
import 'package:whatsapp/presentation/common/widgets/snackbar.dart';

final userInfoRepositoryProvider = Provider((ref) => UserInfoRepository(
    firebaseAuth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance, mapper: UserInfoMapper()));

class UserInfoRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final UserInfoMapper mapper;
  UserInfoRepository({required this.firebaseAuth, required this.firestore, required this.mapper});

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
      );
      await firestore.collection('users').doc(uid).set(user.toJson());
    } catch (err) {
      showSnackBar(content: err.toString());
    }
  }

  Stream<UserInfo> getUserData(String id) {
    return firestore.collection('users').doc(id).snapshots().map((event) => UserInfo.fromMap(event.data()!));
  }

  Future<UserInfo> getCurrentUserData() async {
    var userData = await firestore.collection('users').doc(firebaseAuth.currentUser?.uid).get();
    UserInfo? user;
    if (userData.data() != null) {
      final data = UserInfoModel.fromJson(userData.data()!);
      user = mapper.transformToUserInfo(data);
    }
    return user!;
  }
}
