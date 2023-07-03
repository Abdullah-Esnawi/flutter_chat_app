import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/app_navigator.dart';

void showSnackBar({required String content}) {
  ScaffoldMessenger.of(AppNavigator.globalContext).showSnackBar(SnackBar(content: Text(content)));
}

