import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';

Future<File?> pickImageFromGallery(ImageSource imageSource) async {
  File? image;

  try {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (err) {
    showSnackBar(content: err.toString());
  }
  return image;
}


Future<File?> pickVideoFromGallery() async {
  File? video;

  try {
    final pickedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (err) {
    showSnackBar(content: err.toString());
  }
  return video;
}
