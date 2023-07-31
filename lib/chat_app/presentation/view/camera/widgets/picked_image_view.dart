import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/status_viewmodel.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

class PickedImageView extends ConsumerWidget {
  PickedImageView({Key? key, required this.path}) : super(key: key);
  final String path;
  final _captionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.colors.black,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.crop_rotate,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.emoji_emotions_outlined,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.title,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.edit,
                size: 27,
              ),
              onPressed: () {}),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: AppColors.colors.black.withOpacity(.38),
                width: size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  controller: _captionController,
                  style: TextStyle(
                    color: AppColors.colors.white,
                    fontSize: 17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Caption....",
                    prefixIcon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 27,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    suffixIcon: InkWell(
                      onTap: () async {
                        await ref.read(statusViewmodelProvider).addStatus(File(path), _captionController.text);

                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.colors.primary,
                        child: Icon(
                          Icons.check,
                          color: AppColors.colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
