import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/chat_app/data/models/status_model.dart';
import 'package:whatsapp/chat_app/data/models/user_model.dart';
import 'package:whatsapp/chat_app/domain/usecases/status/upload_status_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/repositories/firebase_storage_repository.dart';

class StatusRemoteDataSource implements BaseStatusRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Ref _ref;

  StatusRemoteDataSource(this._firestore, this._auth, this._ref);

  @override
  Future<void> uploadStatus(UploadStatusParams params) async {
    var statusId = const Uuid().v1();
    String userId = _auth.currentUser!.uid;
    List<String> uidWhoCanSee = [];
    List<String> statusImagesUrls = [];
    List<Contact> contacts = [];

    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(withProperties: true);
    }

   for (var e in contacts)   {
      var phoneNum = e.phones.first.number.replaceAll(' ', '');
      phoneNum = phoneNum.startsWith('+') ? phoneNum.substring(1) : phoneNum;
      var userFirestoreData = await _firestore.collection('users').where('phoneNumber', isEqualTo: "+$phoneNum").get();
      if (userFirestoreData.docs.isNotEmpty) {
        var userData = UserInfoModel.fromMap(userFirestoreData.docs[0].data());
        uidWhoCanSee.add(userData.uid);
      }
    };

    var statusesSnapshot = await _firestore.collection('status').where('uid', isEqualTo: userId).get();

    final imageUrl = await _ref
        .read(commonFirebaseStorageRepoProvider)
        .storeFileToFirebase('/status/$statusId/$userId', params.statusImage);

    if (statusesSnapshot.docs.isNotEmpty) {
      StatusModel status = StatusModel.fromMap(statusesSnapshot.docs[0].data());
      statusImagesUrls = status.photoUrl;
      statusImagesUrls.add(imageUrl);
      _firestore.collection('status').doc(statusesSnapshot.docs[0].id).update({'photoUrl': statusImagesUrls});
      return;
    } else {
      statusImagesUrls = [imageUrl];
    }

    final status = StatusModel(
      uid: userId,
      username: params.username,
      phoneNumber: params.phoneNumber,
      photoUrl: statusImagesUrls,
      createdAt: DateTime.now(),
      profilePic: params.profilePic,
      statusId: statusId,
      whoCanSee: uidWhoCanSee,
      caption: params.caption,
    );

    await _firestore.collection('status').doc(statusId).set(status.toMap());
  }

  @override
  Future<List<StatusModel>> getStatuses() async {
    List<StatusModel> statusesData = [];
    try {
      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
      for (int i = 1; i <= contacts.length; i++) {
        final snapshot = await _firestore
            .collection('status')
            .where('phoneNumber', isEqualTo: contacts[i].phones.first.number.replaceAll(' ', ''))
            .where('createdAt',
                isGreaterThan: DateTime.now().subtract(const Duration(hours: 24)).millisecondsSinceEpoch)
            .get();
        for (var tempData in snapshot.docs) {
          StatusModel tempStatus = StatusModel.fromMap(tempData.data());
          if (tempStatus.whoCanSee.contains(_auth.currentUser!.uid)) {
            statusesData.add(tempStatus);
          }
        }
      }
    } catch (err) {
      ServerException(err.toString());
    }

    return statusesData;
  }
}

abstract class BaseStatusRemoteDataSource {
  Future<void> uploadStatus(UploadStatusParams params);
  Future<List<StatusModel>> getStatuses();
}
