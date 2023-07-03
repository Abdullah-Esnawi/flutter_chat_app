import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/data/models/user_model.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/generated/l10n.dart';

final contactsRemoteDataSourceProvider = Provider((ref) => ContactsRemoteDataSource(FirebaseFirestore.instance));

class ContactsRemoteDataSource implements BaseContactsRemoteDataSource {
  final FirebaseFirestore _firestore;

  ContactsRemoteDataSource(this._firestore);

  // Future<List<Contact>> getContacts(ContactsType contactsType) async {
  //   List<Contact> contacts = [];
  //   try {
  //     if (await FlutterContacts.requestPermission()) {
  //       contacts = await FlutterContacts.getContacts(withProperties: true);
  //     }
  //   } catch (err) {
  //     debugPrint(err.toString());
  //   }
  //   return contacts;
  // }

  @override
  Future<UserInfoModel?> getSelectedContact(String phone) async {
    try {
      final userCollection = await _firestore.collection('users').get();
      bool isFound = false;
      for (var doc in userCollection.docs) {
        var userData = UserInfoModel.fromMap(doc.data());
        // String selectedPhoneNum = selectedContact.phones[0].number.replaceAll(' ', '');

        if (phone.split('').first == '0') {
          phone = phone.replaceFirst('0', '+20');
        }

        if (phone.replaceAll(' ', '') == userData.phoneNumber.replaceAll(' ', '')) {
          isFound == true;

          return userData;
        }
      }
      if (!isFound) {
        CachedException(S.current.numberDoesNotExist);
      }
    } catch (err) {
      CachedException(err.toString());
    }
    return null;
  }
}

abstract class BaseContactsRemoteDataSource {
  Future<UserInfoModel?> getSelectedContact(String phone);
}
