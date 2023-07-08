import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/chat_contact_entity.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';
import 'package:whatsapp/core/x_state/state.dart';

final getChatContactsStreamProvider = StreamProvider<List<ChatContactEntity>>(
  (ref) => ref.watch(chatContactsUseCaseProvider)(const NoParameters()),
);
final getChatMessagesStreamProvider = StreamProvider.family<List<Message>, String>(
  (ref, receiverId) => ref.watch(chatMessagesUseCaseProvider)(receiverId),
);

class ChatViewmodel {
  final SendTextMessageUseCase _sendTextMessageUseCase;
  final SendFileMessageUseCase _sendFileMessageUseCase;

  ChatViewmodel(this._sendTextMessageUseCase, this._sendFileMessageUseCase);
  TextEditingController messageController = TextEditingController();
  Future<RemoteObjectState<void>> sendTextMessage(TextMessageParams params) async {
    var state = const RemoteObjectState.loading();
    final result = await _sendTextMessageUseCase(params);

    result.fold(
      (failure) => state = RemoteObjectState.error(failure.message),
      (success) => state = const RemoteObjectState.data(true),
    );
    return state;
  }

  Future<RemoteObjectState<void>> sendFileMessage(FileMessageParams params) async {
    var state = const RemoteObjectState.loading();
    final result = await _sendFileMessageUseCase(params);

    result.fold(
      (failure) => state = RemoteObjectState.error(failure.message),
      (success) => state = const RemoteObjectState.data(true),
    );
    return state;
  }
}
