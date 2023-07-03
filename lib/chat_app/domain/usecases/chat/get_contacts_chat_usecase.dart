import 'package:whatsapp/chat_app/domain/entities/chat_contact_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetContactsChatUseCase extends StreamBaseUseCase<List<ChatContactEntity>, Map<String, dynamic>> {
  final ChatRepository _repository;

  GetContactsChatUseCase(this._repository);
  @override
  Stream<List<ChatContactEntity>> call(Map<String, dynamic> params) {
    return _repository.getContactsChat(params);
  }
}
