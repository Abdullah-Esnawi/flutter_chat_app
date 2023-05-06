
class UserInfo {
  final String name;
  final String uid;
  final String? profilePic;
  final bool? isOnline;
  final String phoneNumber;
  final List<String>? groupId;
  UserInfo({
    required this.phoneNumber,
    this.groupId,
    required this.name,
    this.profilePic,
    required this.uid,
    this.isOnline,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'],
      isOnline: map['isOnline'],
      phoneNumber: map['phoneNumber'] ?? '',
      groupId: List<String>.from(map['groupId']),
    );
  }


}
