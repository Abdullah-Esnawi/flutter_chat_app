import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/base_select_contact_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

final selectedContactUseCaseProvider = Provider(
  (ref) => GetSelectedContactUseCase(ref.watch(contactsRepositoryProvider)),
);

class GetSelectedContactUseCase extends BaseUseCase<UserInfoEntity?, String> {
  final BaseContactsRepository _selectContactRepository;

  GetSelectedContactUseCase(this._selectContactRepository);

  @override
  Future<Result<Failure, UserInfoEntity?>> call(String phone) async {
    return await _selectContactRepository.getSelectedContact(phone);
  }
}
