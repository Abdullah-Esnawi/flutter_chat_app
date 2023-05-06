import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserInfoModel {
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
  UserInfoModel({required this.groupId, required this.isOnline, required this.name, required this.phoneNumber, required this.profilePic, required this.uid});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
