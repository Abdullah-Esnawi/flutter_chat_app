import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/chat_app/data/models/chat_contact_model.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/generated/l10n.dart';

abstract class BaseSelectContactsLocalDataSource {
  Future<List<Contact>> getContacts(ContactsType contactsType);
}

class ContactsLocalDataSource extends BaseSelectContactsLocalDataSource {
  @override
  Future<List<Contact>> getContacts(ContactsType contactsType) async {
    if (await FlutterContacts.requestPermission()) {
      return await FlutterContacts.getContacts(
        withProperties: true,
      );
    } else {
      throw CachedException(S.current.somethingWentWrong);
    }
  }
}
