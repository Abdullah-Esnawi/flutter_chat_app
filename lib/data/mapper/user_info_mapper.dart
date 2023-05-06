import 'package:whatsapp/data/models/user_model.dart';

import '../../domain/entities/user_entities.dart';

class UserInfoMapper {
  UserInfo? transformToUserInfo(UserInfoModel? input) {
    final phoneNumber = input?.phoneNumber;
    final name = input?.name;
    final uid = input?.uid;
    final groupId = input?.groupId;
    final profilePic = input?.profilePic;
    final isOnline = input?.isOnline;
    if (phoneNumber == null || name == null || uid == null) {
      return null;
    }
    return UserInfo(
      phoneNumber: phoneNumber,
      groupId: groupId,
      name: name,
      profilePic: profilePic,
      uid: uid,
      isOnline: isOnline,
    );
  }
}
