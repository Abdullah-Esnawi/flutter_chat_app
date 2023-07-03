import 'package:equatable/equatable.dart';
import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class SetChatMessageSeenUseCase extends BaseUseCase<void, SetChatMessageSeenParams> {
  final ChatRepository _repository;

  SetChatMessageSeenUseCase(this._repository);
  @override
  Future<Result<Failure, void>> call(SetChatMessageSeenParams params) async {
    return await _repository.setChatMessageSeen(params);
  }
}

class SetChatMessageSeenParams extends Equatable {
  final String receiverId;
  final String messageId;

  const SetChatMessageSeenParams({required this.receiverId, required this.messageId});

  @override
  List<Object?> get props => [
        receiverId,
        messageId,
      ];
}
