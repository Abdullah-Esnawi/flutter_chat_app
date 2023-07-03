import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final String name;
  final String uid;
  final String profilePic;
  final String phoneNumber;
  final bool isOnline;
  final List<String> groupId;
  final String status;
  final DateTime? lastSeen;

  const UserInfoEntity({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.phoneNumber,
    required this.isOnline,
    required this.groupId,
    required this.status,
    this.lastSeen,
  });

  @override
  List<Object?> get props => [name, status, profilePic, phoneNumber, isOnline, groupId, lastSeen];
}
