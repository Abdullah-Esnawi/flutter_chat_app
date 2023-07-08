import 'package:whatsapp/chat_app/domain/entities/chat_contact_entity.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_gif_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/set_chat_message_seen_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

abstract class ChatRepository {
  const ChatRepository();

  Future<Result<Failure, void>> sendTextMessage(TextMessageParams parameters);
  Future<Result<Failure, void>> sendFileMessage(FileMessageParams parameters);
  Future<Result<Failure, void>> sendGifMessage(GifMessageParams parameters);
  Future<Result<Failure, void>> setChatMessageSeen(SetChatMessageSeenParams parameters);
  Stream<List<ChatContactEntity>> getChatContacts();
  Stream<List<Message>> getChatMessages(String receiverId);
  Stream<int> getNumOfMessageNotSeen(String senderId);
}
