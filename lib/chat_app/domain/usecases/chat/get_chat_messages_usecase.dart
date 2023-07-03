
import 'package:equatable/equatable.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetChatMessagesUseCase extends StreamBaseUseCase<List<Message>, GetChatMessagesParams> {
  final ChatRepository _repository;

  GetChatMessagesUseCase(this._repository);

  @override
  Stream<List<Message>> call(GetChatMessagesParams params) {
    return _repository.getChatMessages(params);
  }
}

class GetChatMessagesParams extends Equatable {
  final String receiverId;

  const GetChatMessagesParams({
    required this.receiverId,
  });

  @override
  List<Object?> get props => [
        receiverId,
      ];
}
