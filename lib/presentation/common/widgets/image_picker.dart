import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/presentation/common/widgets/snackbar.dart';

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;

  try {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (err) {
    showSnackBar(content: err.toString());
  }
  return image;
}
