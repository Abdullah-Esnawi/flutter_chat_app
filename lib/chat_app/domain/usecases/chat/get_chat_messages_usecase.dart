
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetChatMessagesUseCase extends StreamBaseUseCase<List<Message>, String> {
  final ChatRepository _repository;

  GetChatMessagesUseCase(this._repository);

  @override
  Stream<List<Message>> call(String receiverId) {
    return _repository.getChatMessages(receiverId);
  }
}

