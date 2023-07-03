import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:whatsapp/chat_app/data/models/chat_contact_model.dart';
import 'package:whatsapp/chat_app/domain/repository/base_select_contact_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetContactsNotOnWhatsUseCase extends BaseUseCase<List<Contact>, NoParameters> {
  final BaseContactsRepository _baseSelectContactRepository;

  GetContactsNotOnWhatsUseCase(this._baseSelectContactRepository);
  @override
  Future<Result<Failure, List<Contact>>> call(NoParameters parameters) async {
    return await _baseSelectContactRepository.getContacts(ContactsType.notIncludedInApp);
  }
}
