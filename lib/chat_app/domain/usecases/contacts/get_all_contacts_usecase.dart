import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/data/models/chat_contact_model.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/repository/base_select_contact_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

final getAllContactsUseCaseProvider = Provider((ref) => GetAllContactsUseCase(ref.watch(contactsRepositoryProvider)));

class GetAllContactsUseCase extends BaseUseCase<List<Contact>, NoParameters> {
  final BaseContactsRepository _baseSelectContactRepository;

  GetAllContactsUseCase(this._baseSelectContactRepository);
  @override
  Future<Result<Failure, List<Contact>>> call(NoParameters params) async {
    return await _baseSelectContactRepository.getContacts(ContactsType.all);
  }
}
