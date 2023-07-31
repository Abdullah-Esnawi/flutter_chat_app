import 'dart:convert';

import 'package:flutter/foundation.dart';

class StatusEntity {
  final String uid;
  final String username;
  final String phoneNumber;
  final String? caption;
  final List<String> photoUrl;
  final DateTime createdAt;
  final String profilePic;
  final String statusId;
  final List<String> whoCanSee;
  StatusEntity({
    required this.uid,
    required this.username,
    required this.phoneNumber,
    required this.photoUrl,
    required this.createdAt,
    required this.profilePic,
    required this.statusId,
    required this.whoCanSee,
    this.caption,
  });
}
