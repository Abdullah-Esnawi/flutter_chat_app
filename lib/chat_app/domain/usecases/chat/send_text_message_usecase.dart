import 'package:equatable/equatable.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class SendTextMessageUseCase extends BaseUseCase<void, TextMessageParams> {
  final ChatRepository _repository;

  SendTextMessageUseCase(this._repository);

  @override
  Future<Result<Failure, void>> call(TextMessageParams params) async {
    return await _repository.sendTextMessage(params);
  }
}

class TextMessageParams extends Equatable {
  final String text;
  final String receiverId;
  final MessageReplay? messageReplay;

  const TextMessageParams({
    required this.receiverId,
    required this.text,
    this.messageReplay,
  });

  @override
  List<Object?> get props => [
        text,
        receiverId,
        messageReplay,
      ];
}
