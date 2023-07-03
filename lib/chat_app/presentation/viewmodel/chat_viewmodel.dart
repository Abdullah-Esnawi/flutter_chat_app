import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/core/x_state/state.dart';

final chatViewmodelProvider = Provider((ref) => ChatViewmodel(ref.watch(sentTextMessageUseCase)));

class ChatViewmodel {
  final SendTextMessageUseCase _sendTextMessageUseCase;
  ChatViewmodel(this._sendTextMessageUseCase);
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
}
