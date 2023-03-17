import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "uid")
  String? uid;
  @JsonKey(name: "profilePic")
  String? profilePic;
  @JsonKey(name: "isOnline")
  bool? isOnline;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "groupId")
  List<String>? groupId;
  UserEntity({required this.groupId, required this.isOnline, required this.name, required this.phoneNumber, required this.profilePic, required this.uid});

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
