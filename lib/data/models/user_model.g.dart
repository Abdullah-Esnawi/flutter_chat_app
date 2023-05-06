// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      groupId:
          (json['groupId'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isOnline: json['isOnline'] as bool?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profilePic: json['profilePic'] as String?,
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'profilePic': instance.profilePic,
      'isOnline': instance.isOnline,
      'phoneNumber': instance.phoneNumber,
      'groupId': instance.groupId,
    };
