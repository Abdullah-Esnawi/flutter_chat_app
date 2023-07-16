import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/resources/widgets/file_picker.dart';

class CameraAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onFlashPressed;
  final bool isFlashOn;

  const CameraAppBar({
    super.key,
    required this.onFlashPressed,
    required this.isFlashOn,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
      leading: IconButton(
        // iconSize: 30,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.clear),
      ),
      actions: [
        IconButton(
          onPressed: onFlashPressed,
          icon: Icon(
            isFlashOn ? Icons.flash_on : Icons.flash_off,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SelectImageFromGalleryButton extends StatelessWidget {
  final String receiverId;

  const SelectImageFromGalleryButton({
    super.key,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectImageFromGallery(context);
      },
      child: const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black38,
        child: Icon(
          Icons.photo,
          size: 30,
        ),
      ),
    );
  }

  void selectImageFromGallery(BuildContext context) async {
    await pickImageFromGallery(ImageSource.gallery).then((img) {
      if (img != null) {
        Navigator.pushNamed(
          context,
          Routes.pickedImageView,
          arguments: {
            'path': img.path,
            'uid': receiverId, //
          },
        );
      }
    });
  }
}
