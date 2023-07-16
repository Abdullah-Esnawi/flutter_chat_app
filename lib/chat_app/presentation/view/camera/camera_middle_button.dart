import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/presentation/view/camera/camera_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/camera/camera_screen0.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';

class CameraMiddleButton extends ConsumerWidget {
  final CameraController controller;
  final VoidCallback onLongPress;
  final VoidCallback onTap;
  final VoidCallback onLongPressUp;
  const CameraMiddleButton({
    required this.onLongPress,
    required this.onTap,
    required this.onLongPressUp,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onLongPress: onLongPress,
      // onLongPressUp: () {
      //   controller.stopVideoRecording();
      //   ref.read(cameraIsRecording.notifier).state = false;
      // },
      onLongPressUp: onLongPressUp,
      onTap:onTap ,
      child: ref.watch(cameraIsRecording) == false
          ? Icon(
              Icons.circle_outlined,
              size: 70,
              color: AppColors.colors.white,
            )
          : Icon(
              Icons.radio_button_on_outlined,
              size: 70,
              color: AppColors.colors.danger,
            ),
    );
  }
}
