import 'package:whatsapp/chat_app/domain/entities/chat_contact_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetChatContactsUseCase extends StreamBaseUseCase<List<ChatContactEntity>,NoParameters> {
  final ChatRepository _repository;

  GetChatContactsUseCase(this._repository);
  @override
  Stream<List<ChatContactEntity>> call(NoParameters params) {
    return _repository.getChatContacts();
  }
}
