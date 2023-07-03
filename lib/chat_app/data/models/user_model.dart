import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/generated/l10n.dart';

class UserInfoModel extends UserInfoEntity {
  const UserInfoModel({
    required String name,
    required String uid,
    required String profilePic,
    required String phoneNumber,
    required bool isOnline,
    required List<String> groupId,
    DateTime? lastSeen, // TODO: Remove this if not needed
    String status = 'offline',
  }) : super(
          name: name,
          uid: uid,
          status: status,
          profilePic: profilePic,
          phoneNumber: phoneNumber,
          isOnline: isOnline,
          groupId: groupId,
          lastSeen: lastSeen,
        );

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      name: map['name'],
      uid: map['uid'],
      status: map['status'] ?? S.current.offline,
      profilePic: map['profilePic'],
      phoneNumber: map['phoneNumber'],
      isOnline: map['isOnline'],
      groupId: List<String>.from(map['groupId']),
      // lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'status': status,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'groupId': groupId,
      'lastSeen': lastSeen!.millisecondsSinceEpoch,
    };
  }
}
