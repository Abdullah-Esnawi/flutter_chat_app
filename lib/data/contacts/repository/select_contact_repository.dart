import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/data/user_info/entity/user_entity.dart';
import 'package:whatsapp/data/user_info/mapper/mapper.dart';
import 'package:whatsapp/domain/user_info/entity/user_model.dart';
import 'package:whatsapp/presentation/common/widgets/snackbar.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';

final userInfoMapperProvider = Provider((ref) => UserInfoMapper());

final selectContactRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    FirebaseFirestore.instance,
    ref.watch(userInfoMapperProvider),
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;
  final UserInfoMapper _mapper;
  SelectContactRepository(this.firestore, this._mapper);

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    // need refactor for this logic to know users using this app and navigate to user chat if it found on Firebase
    try {
      final userCollection = await firestore.collection('users').get();
      bool isFound = false;
      for (var doc in userCollection.docs) {
        var userData = _mapper.transformToUserInfo(UserEntity.fromJson(doc.data()));
        String selectedPhoneNum = selectedContact.phones[0].number.replaceAll(' ', '');
        if (selectedPhoneNum.split('').first == '0') {
          selectedPhoneNum = selectedPhoneNum.replaceFirst('0', '+20');
        }
        if (selectedPhoneNum == userData!.phoneNumber) {
          isFound == true;
          Navigator.pushNamed(context, Routes.mobileChatScreen);
          debugPrint(selectedPhoneNum);
        } else {
          debugPrint(selectedPhoneNum);
          showSnackBar(content: 'This number does not exist on this app.');
        }
      }
    } catch (err) {
      showSnackBar(content: err.toString());
    }
  }
}
