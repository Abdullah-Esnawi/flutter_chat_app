import 'package:dartz/dartz.dart';
import 'package:whatsapp/chat_app/data/data_source/chat/chat_remote_data_source.dart';
import 'package:whatsapp/chat_app/domain/entities/chat_contact_entity.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/get_chat_messages_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_gif_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/set_chat_message_seen_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remote;

  ChatRepositoryImpl(this._remote);

  @override
  Future<Result<Failure, void>> sendTextMessage(TextMessageParams params) async {
    try {
      _remote.sendTextMessage(params);
      return const Right(true);
    } catch (err) {
      return Left(ServerFailure(err.toString()));
    }
  }

  @override
  Stream<List<Message>> getChatMessages(GetChatMessagesParams parameters) {
    // TODO: implement getChatMessages
    throw UnimplementedError();
  }

  @override
  Stream<List<ChatContactEntity>> getContactsChat(Map<String, dynamic> map) {
    // TODO: implement getContactsChat
    throw UnimplementedError();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    // TODO: implement getNumOfMessageNotSeen
    throw UnimplementedError();
  }

  @override
  Future<Result<Failure, void>> sendFileMessage(FileMessageParams parameters) {
    // TODO: implement sendFileMessage
    throw UnimplementedError();
  }

  @override
  Future<Result<Failure, void>> sendGifMessage(GifMessageParams parameters) {
    // TODO: implement sendGifMessage
    throw UnimplementedError();
  }

  @override
  Future<Result<Failure, void>> setChatMessageSeen(SetChatMessageSeenParams parameters) {
    // TODO: implement setChatMessageSeen
    throw UnimplementedError();
  }
}
