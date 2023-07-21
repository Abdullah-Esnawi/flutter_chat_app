
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/file_type_widget.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/resources/widgets/file_picker.dart';
import 'package:whatsapp/generated/l10n.dart';

class SelectMessageTypeDialog extends ConsumerWidget {
  final String receiverId;
  const SelectMessageTypeDialog(this.receiverId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = S.of(context);
    return Dialog(
      backgroundColor: AppColors.colors.transparent,
      insetAnimationCurve: Curves.bounceInOut,
      child: Container(
        height: 340,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.colors.neutral45, borderRadius: BorderRadius.circular(26)),
        child: Center(
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 16),
              children: [
                FileTypeItem(
                  typeName: strings.docFileTypeName,
                  icon: Icons.file_present_rounded,
                  background: const Color.fromARGB(255, 202, 97, 250),
                  onPressed: () {},
                ),
                FileTypeItem(
                  typeName: strings.cameraFileTypeName,
                  icon: Icons.camera_alt,
                  background: const Color.fromARGB(255, 254, 46, 116),
                  onPressed: () async {
                    final image = await pickVideoFromGallery().then((value) {
                      Navigator.pop(context);
                      return value;
                    });

                    if (image != null) {
                      await ref.read(chatViewmodelProvider).sendFileMessage(
                            FileMessageParams(
                              receiverId: receiverId,
                              messageType: MessageType.video,
                              file: File(image.path),
                            ),
                          );
                    }
                  },
                ),
                FileTypeItem(
                  typeName: strings.galleryFileTypeName,
                  icon: Icons.photo_outlined,
                  background: const Color.fromARGB(255, 127, 102, 254),
                  onPressed: () async {
                    final image = await pickImageFromGallery(ImageSource.gallery).then((value) {
                      Navigator.pop(context);
                      return value;
                    });

                    if (image != null) {
                      await ref.read(chatViewmodelProvider).sendFileMessage(
                            FileMessageParams(
                              receiverId: receiverId,
                              messageType: MessageType.image,
                              file: File(image.path),
                            ),
                          );
                    }
                  },
                ),
                FileTypeItem(
                  typeName: strings.contactFileTypeName,
                  icon: Icons.person,
                  background: const Color.fromARGB(255, 1, 157, 225),
                  onPressed: () {},
                ),
                FileTypeItem(
                  typeName: strings.locationFileTypeName,
                  icon: Icons.location_on_outlined,
                  background: const Color.fromARGB(255, 29, 166, 84),
                  onPressed: () {},
                ),
                FileTypeItem(
                  typeName: strings.audioFileTypeName,
                  icon: Icons.headphones_outlined,
                  background: const Color.fromARGB(255, 250, 101, 51),
                  onPressed: () {},
                ),
                FileTypeItem(
                  typeName: strings.pollFileTypeName,
                  icon: Icons.poll_outlined,
                  background: const Color.fromARGB(255, 0, 166, 152),
                  onPressed: () {},
                ),
              ]),
        ),
      ),
    );
  }
}