import 'package:equatable/equatable.dart';
import 'package:whatsapp/core/resources/enums.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String senderName;
  final String text;
  final String messageId;
  final DateTime timeSent;
  final bool isSeen;
  final MessageType messageType;
  final String repliedMessage;
  final String repliedTo;
  final MessageType? repliedMessageType;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.text,
    required this.messageId,
    required this.timeSent,
    required this.isSeen,
    required this.messageType,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  @override
  List<Object?> get props => [
        senderId,
        text,
        messageId,
        timeSent,
        isSeen,
        messageType,
        repliedMessage,
        repliedTo,
        repliedMessageType,
      ];
}

class MessageReplay extends Equatable {
  final String message;
  final bool isMe;
  final MessageType messageType;
  final String repliedTo;

  const MessageReplay({
    required this.message,
    required this.isMe,
    required this.messageType,
    required this.repliedTo,
  });

  @override
  List<Object?> get props => [
        message,
        isMe,
        messageType,
        repliedTo,
      ];
}
