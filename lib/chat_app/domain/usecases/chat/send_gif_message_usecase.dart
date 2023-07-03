import 'package:equatable/equatable.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class SendGifMessageUseCase extends BaseUseCase<void, GifMessageParams> {
  final ChatRepository _repository;

  SendGifMessageUseCase(this._repository);

  @override
  Future<Result<Failure, void>> call(GifMessageParams params) async {
    return await _repository.sendGifMessage(params);
  }
}

class GifMessageParams extends Equatable {
  final String receiverId;
  final String gifUrl;
  final MessageReplay? messageReplay;

  const GifMessageParams({
    required this.receiverId,
    required this.gifUrl,
    this.messageReplay,
  });

  @override
  List<Object?> get props => [
        receiverId,
        gifUrl,
        messageReplay,
      ];
}
