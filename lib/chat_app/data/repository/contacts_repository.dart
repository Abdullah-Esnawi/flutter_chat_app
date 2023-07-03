import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/chat_app/data/data_source/contact/contacts_local_data_source.dart';
import 'package:whatsapp/chat_app/data/data_source/contact/contacts_remote_data_source.dart';
import 'package:whatsapp/chat_app/data/models/chat_contact_model.dart';
import 'package:whatsapp/chat_app/data/models/user_model.dart';
import 'package:whatsapp/chat_app/domain/repository/base_select_contact_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/generated/l10n.dart';

class ContactsRepository implements BaseContactsRepository {
  final ContactsRemoteDataSource _remote;
  final ContactsLocalDataSource _local;
  ContactsRepository(this._remote, this._local);

  @override
  Future<Result<Failure, List<Contact>>> getContacts(ContactsType contactsType) async {
    final contacts = await _local.getContacts(contactsType);
    if (contacts.isEmpty) {
      return Left(CachedFailure(S.current.youDontHaveContacts));
    }
    return Right(contacts);
  }

  @override
  Future<Result<Failure, UserInfoModel?>> getSelectedContact(String phoneNumber) async {
    var contact = await _remote.getSelectedContact(phoneNumber);
    if (contact != null) {
      return Right(contact);
    }
    return Left(ServerFailure(S.current.numberDoesNotExist));
  }
}
