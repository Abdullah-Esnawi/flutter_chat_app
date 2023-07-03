import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class SendFileMessageUseCase extends BaseUseCase<void, FileMessageParams> {
  final ChatRepository _repository;

  SendFileMessageUseCase(this._repository);

  @override
  Future<Result<Failure, void>> call(FileMessageParams params) async {
    return await _repository.sendFileMessage(params);
  }
}

class FileMessageParams extends Equatable {
  final String receiverId;
  final MessageType messageType;
  final File file;
  final MessageReplay? messageReplay;

  const FileMessageParams({
    required this.receiverId,
    required this.messageType,
    required this.file,
    this.messageReplay,
  });

  @override
  List<Object?> get props => [
        receiverId,
        messageType,
        file,
        messageReplay,
      ];
}
