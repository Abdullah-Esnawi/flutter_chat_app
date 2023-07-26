import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/app_navigator.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

void showSnackBar({required String content, Duration? duration}) {
  ScaffoldMessenger.of(AppNavigator.globalContext).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: AppColors.colors.black,
    duration: duration ?? Duration(seconds: 2),
  ));
}
