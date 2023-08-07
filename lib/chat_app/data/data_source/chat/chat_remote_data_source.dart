import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/data/models/chat_contact_model.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/chat_app/data/models/message_model.dart';
import 'package:whatsapp/chat_app/data/models/user_model.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_gif_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/set_chat_message_seen_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/repositories/firebase_storage_repository.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/generated/l10n.dart';

abstract class BaseChatRemoteDataSource {
  Future<void> sendTextMessage(TextMessageParams params);
  Stream<List<ChatContactModel>> getChatContacts();
  Stream<List<MessageModel>> getChatMessages(String receiverId);
  Future<void> sendFileMessage(FileMessageParams parameters);
  Future<void> sendGIFMessage(GifMessageParams parameters);
  Future<void> setChatMessageSeen(SetChatMessageSeenParams parameters);
  Stream<int> getNumOfMessageNotSeen(String senderId);
}

class ChatRemoteDataSource implements BaseChatRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Ref _ref;
  const ChatRemoteDataSource(this._firestore, this._auth, this._ref);

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
      senderName: senderUserName,
      repliedMessage: messageReplay == null ? '' : messageReplay.message,
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

  @override
  Stream<List<ChatContactModel>> getChatContacts() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .orderBy('timeSent', descending: true)
        .snapshots()
        .asyncMap((event) async {
      List<ChatContactModel> contacts = [];
      for (var document in event.docs) {
        ChatContactModel contactChat = ChatContactModel.fromMap(document.data());
        var userData = await _firestore.collection('users').doc(contactChat.contactId).get();
        if (userData.data() != null) {
          var user = UserInfoModel.fromMap(userData.data()!);

          UserInfoModel.fromMap(userData.data()!);
          contacts.add(
            ChatContactModel(
              name: user.name,
              profilePic: user.profilePic,
              contactId: user.uid,
              lastMessage: contactChat.lastMessage,
              timeSent: contactChat.timeSent,
              phoneNumber: contactChat.phoneNumber,
            ),
          );
        }
      }
      return contacts;
    });
  }

  @override
  Stream<List<MessageModel>> getChatMessages(String receiverId) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        messages.add(MessageModel.fromMap(document.data()));
      }
      return messages;
    });
  }

  @override
  Future<void> sendFileMessage(FileMessageParams parameters) async {
    DateTime timeSent = DateTime.now();
    String messageId = const Uuid().v1();
    UserInfoModel senderUser = await _currentUser();
    var fileUrl = await _ref.watch(commonFirebaseStorageRepoProvider).storeFileToFirebase(
          'chat/${parameters.messageType.type}/${senderUser.uid}/${parameters.receiverId}/$messageId}',
          parameters.file,
        );
    UserInfoModel receiverUserData;

    var userDataMap = await _firestore.collection('users').doc(parameters.receiverId).get();
    receiverUserData = UserInfoModel.fromMap(userDataMap.data()!);

    String contactMessage;
    switch (parameters.messageType) {
      case MessageType.image:
        contactMessage = '📷 Photo';
        break;
      case MessageType.video:
        contactMessage = '🎥 Video';
        break;
      case MessageType.audio:
        contactMessage = '🎙️ Audio';
        break;
      case MessageType.gif:
        contactMessage = 'Gif';
        break;
      default:
        contactMessage = 'Other';
    }

    _saveDataToContactsSubCollection(
      senderUser,
      receiverUserData,
      contactMessage,
      timeSent,
    );
    _saveMessageToMessageSubCollection(
        senderId: senderUser.uid,
        receiverId: parameters.receiverId,
        text: fileUrl,
        timeSent: timeSent,
        messageId: messageId,
        messageType: parameters.messageType,
        messageReplay: parameters.messageReplay,
        senderUserName: senderUser.name);
  }

  @override
  Future<void> sendGIFMessage(GifMessageParams parameters) async {
    UserInfoModel receiverUserData;
    var timeSent = DateTime.now();
    var messageId = const Uuid().v1();
    var userDataMap = await _firestore.collection('users').doc(parameters.receiverId).get();
    receiverUserData = UserInfoModel.fromMap(userDataMap.data()!);
    UserInfoModel senderUser = await _currentUser();
    _saveDataToContactsSubCollection(
      senderUser,
      receiverUserData,
      'Gif',
      timeSent,
    );
    _saveMessageToMessageSubCollection(
        senderId: senderUser.uid,
        receiverId: parameters.receiverId,
        text: parameters.gifUrl,
        timeSent: timeSent,
        messageId: messageId,
        messageType: MessageType.gif,
        senderUserName: senderUser.name,
        messageReplay: parameters.messageReplay);
  }

  void _saveDataToContactsSubCollection(
    UserInfoModel senderUserData,
    UserInfoModel receiverUserData,
    String text,
    DateTime timeSent,
  ) async {
    // users -> receiver user id => chats -> current user id -> set data
    ChatContactModel receiverChatContact = ChatContactModel(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      lastMessage: text,
      timeSent: timeSent,
      phoneNumber: senderUserData.phoneNumber,
    );
    await _firestore
        .collection('users')
        .doc(receiverUserData.uid)
        .collection('chats')
        .doc(senderUserData.uid)
        .set(receiverChatContact.toMap());

    // users -> current user id => chats -> receiver user id -> set data
    ChatContactModel senderChatContact = ChatContactModel(
      name: receiverUserData.name,
      profilePic: receiverUserData.profilePic,
      contactId: receiverUserData.uid,
      lastMessage: text,
      timeSent: timeSent,
      phoneNumber: receiverUserData.phoneNumber,
    );
    await _firestore
        .collection('users')
        .doc(senderUserData.uid)
        .collection('chats')
        .doc(receiverUserData.uid)
        .set(senderChatContact.toMap());
  }

  @override
  Future<void> setChatMessageSeen(SetChatMessageSeenParams parameters) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(parameters.receiverId)
        .collection('messages')
        .doc(parameters.messageId)
        .update({
      'isSeen': true,
    });
    // users -> receiver id -> chats -> sender id -> messages ->message id ->store message
    await _firestore
        .collection('users')
        .doc(parameters.receiverId)
        .collection('chats')
        .doc(_auth.currentUser!.uid)
        .collection('messages')
        .doc(parameters.messageId)
        .update({
      'isSeen': true,
    });
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      int num = 0;
      for (var document in event.docs) {
        MessageModel message = MessageModel.fromMap(document.data());
        if (message.senderId == senderId) {
          if (!message.isSeen) {
            num++;
          }
        }
      }
      return num;
    });
  }
}
