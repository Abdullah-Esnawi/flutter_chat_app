import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/chat_contact_entity.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_gif_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/set_chat_message_seen_usecase.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/bottom_chat_filed.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';
import 'package:whatsapp/core/x_state/state.dart';
import 'package:whatsapp/generated/l10n.dart';

final getChatContactsStreamProvider = StreamProvider<List<ChatContactEntity>>(
  (ref) => ref.watch(chatContactsUseCaseProvider)(const NoParameters()),
);
final getChatMessagesStreamProvider = StreamProvider.family<List<Message>, String>(
  (ref, receiverId) => ref.watch(chatMessagesUseCaseProvider)(receiverId),
);

class ChatViewmodel {
  final SendTextMessageUseCase _sendTextMessageUseCase;
  final SendFileMessageUseCase _sendFileMessageUseCase;
  final SendGifMessageUseCase _sendGifMessageUseCase;
  final SetChatMessageSeenUseCase _setChatMessageSeenUseCase;
  final Ref _ref;

  ChatViewmodel(this._sendTextMessageUseCase, this._sendFileMessageUseCase, this._sendGifMessageUseCase, this._ref,
      this._setChatMessageSeenUseCase);
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

  Future<GiphyGif?> pickGif(BuildContext context) async {
    GiphyGif? gif;
    gif = await Giphy.getGif(
      context: context,
      apiKey: '7S4h2vs1Dc2bAcmBf0t1PoYvY4KSjWXr',
    );
    return gif;
  }

  Future<RemoteObjectState<void>> sendGifMessage(GifMessageParams params) async {
    var state = const RemoteObjectState.loading();
    final result = await _sendGifMessageUseCase(params);

    result.fold(
      (failure) => state = RemoteObjectState.error(failure.message),
      (success) => state = const RemoteObjectState.data(true),
    );
    return state;
  }

  Future<void> setMessageSeen(SetChatMessageSeenParams params) async {
    await _setChatMessageSeenUseCase(params);
  }
}
