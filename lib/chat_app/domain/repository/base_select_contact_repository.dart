import 'package:flutter_contacts/contact.dart';
import 'package:whatsapp/chat_app/data/models/chat_contact_model.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

abstract class BaseContactsRepository {
  Future<Result<Failure, List<Contact>>> getContacts(ContactsType contactsType);
  Future<Result<Failure, UserInfoEntity?>> getSelectedContact(String phoneNumber);
}
