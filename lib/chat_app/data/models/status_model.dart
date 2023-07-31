import 'package:whatsapp/chat_app/domain/entities/status_entity.dart';

class StatusModel extends StatusEntity {
  StatusModel({
    required super.uid,
    required super.username,
    required super.phoneNumber,
    required super.photoUrl,
    required super.createdAt,
    required super.profilePic,
    required super.statusId,
    required super.whoCanSee,
     super.caption,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'profilePic': profilePic,
      'statusId': statusId,
      'whoCanSee': whoCanSee,
      'caption': caption,
    };
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      uid: map['uid'],
      username: map['username'],
      caption: map['caption'],
      phoneNumber: map['phoneNumber'],
      photoUrl: List<String>.from(map['photoUrl']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      profilePic: map['profilePic'],
      statusId: map['statusId'],
      whoCanSee: List<String>.from(map['whoCanSee']),
    );
  }
}
