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

}
