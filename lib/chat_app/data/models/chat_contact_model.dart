import 'package:whatsapp/chat_app/domain/entities/chat_contact_entity.dart';

class ChatContactModel extends ChatContactEntity {
 const ChatContactModel({
    required String name,
    required String contactId,
    required DateTime timeSent,
    required String lastMessage,
    required String phoneNumber,
    required String profilePic,
  }) : super(
          name: name,
          phoneNumber: phoneNumber,
          contactId: contactId,
          timeSent: timeSent,
          lastMessage: lastMessage,
          profilePic: profilePic,
        );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'lastMessage': lastMessage,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'phoneNumber': phoneNumber,
    };
  }

  factory ChatContactModel.fromMap(Map<String, dynamic> map) {
    return ChatContactModel(
        name: map['name'],
        contactId: map['contactId'],
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        lastMessage: map['lastMessage'],
        phoneNumber: map['phoneNumber'],
        profilePic: map['profilePic']);
  }
}


enum ContactsType {
  notIncludedInApp,
  includedInApp,
  all
}