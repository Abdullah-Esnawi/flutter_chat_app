import 'package:whatsapp/data/user_info/entity/user_entity.dart';
import 'package:whatsapp/domain/user_info/entity/user_model.dart';

class UserInfoMapper {
  UserInfo? transformToUserInfo(UserEntity? input) {
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
