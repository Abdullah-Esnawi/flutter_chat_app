import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/chat_app/data/models/chat_contact_model.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/chat_app/data/models/message_model.dart';
import 'package:whatsapp/chat_app/data/models/user_model.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/resources/enums.dart';

abstract class BaseChatRemoteDataSource {
  Future<void> sendTextMessage(TextMessageParams params);
}

class ChatRemoteDataSource implements BaseChatRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  const ChatRemoteDataSource(this._firestore, this._auth);

  @override
  Future<void> sendTextMessage(TextMessageParams params) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      final UserInfoModel? receiverData;
      UserInfoModel senderUser = await _currentUser();
      var userDataMap = await _firestore.collection('users').doc(params.receiverId).get();
      receiverData = UserInfoModel.fromMap(userDataMap.data()!);

      await _saveDataToContactsSubcollection(
        sender: senderUser,
        receiver: receiverData,
        text: params.text,
        timeSent: timeSent,
      );

      _saveMessageToMessageSubCollection(
        senderId: senderUser.uid,
        receiverId: params.receiverId,
        text: params.text,
        timeSent: timeSent,
        messageId: messageId,
        messageType: MessageType.text,
        messageReplay: params.messageReplay,
        senderUserName: senderUser.name,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<void> _saveDataToContactsSubcollection({
    required UserInfoModel sender,
    required UserInfoModel receiver,
    required String text,
    required DateTime timeSent,
  }) async {
    ChatContactModel receiverChatContact = ChatContactModel(
      name: sender.name,
      profilePic: sender.profilePic,
      contactId: sender.uid,
      lastMessage: text,
      timeSent: timeSent,
      phoneNumber: sender.phoneNumber,
    );
    await _firestore
        .collection('users')
        .doc(receiver.uid)
        .collection('chats')
        .doc(sender.uid)
        .set(receiverChatContact.toMap());

    ChatContactModel senderChatContact = ChatContactModel(
      name: sender.name,
      profilePic: receiver.profilePic,
      contactId: receiver.uid,
      lastMessage: text,
      timeSent: timeSent,
      phoneNumber: receiver.phoneNumber,
    );
    await _firestore
        .collection('users')
        .doc(sender.uid)
        .collection('chats')
        .doc(receiver.uid)
        .set(senderChatContact.toMap());
  }

  Future<UserInfoModel> _currentUser() async {
    var userDataMap = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    UserInfoModel user = UserInfoModel.fromMap(userDataMap.data()!);
    return user;
  }

  Future<void> _saveMessageToMessageSubCollection({
    required String senderId,
    required String receiverId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required MessageType messageType,
    MessageReplay? messageReplay,
    required String senderUserName,
  }) async {
    MessageModel message = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      messageId: messageId,
      timeSent: timeSent,
      isSeen: false,
      messageType: messageType,
      repliedMessage: messageReplay == null ? '' : messageReplay.message,
      senderName: senderUserName,
      repliedTo: messageReplay == null
          ? ''
          : messageReplay.isMe
              ? senderUserName
              : messageReplay.repliedTo,
      repliedMessageType: messageReplay == null ? MessageType.text : messageReplay.messageType,
    );
    // users -> sender id -> chats -> receiver id -> messages ->message id ->store message
    await _firestore
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
    // users -> receiver id -> chats -> sender id -> messages ->message id ->store message
    await _firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }
}
