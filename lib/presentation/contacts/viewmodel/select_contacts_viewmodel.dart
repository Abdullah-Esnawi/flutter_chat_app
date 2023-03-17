import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/data/contacts/repository/select_contact_repository.dart';

final getContactsProvider = FutureProvider(
  (ref) => ref.watch(selectContactRepositoryProvider).getContacts(),
);

final selectContactViewmodelProvider = Provider(
  (ref) => SelectContactViewmodel(
    ref.watch(selectContactRepositoryProvider),
  ),
);

class SelectContactViewmodel {
  final SelectContactRepository _repository;
  SelectContactViewmodel(this._repository);
  void selectContact(Contact selectedContact, BuildContext context) async {
     _repository.selectContact(selectedContact, context);
  }
}
