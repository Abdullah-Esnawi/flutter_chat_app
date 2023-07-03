import 'package:equatable/equatable.dart';

class ChatContactEntity extends Equatable {
  final String name;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;
  final String phoneNumber;
  final String? profilePic;

  const ChatContactEntity({
    required this.phoneNumber,
    required this.name,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
    this.profilePic,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        name,
        contactId,
        timeSent,
        lastMessage,
        profilePic,
      ];
}
