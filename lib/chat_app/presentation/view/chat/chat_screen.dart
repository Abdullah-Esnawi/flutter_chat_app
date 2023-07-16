import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';
import 'package:whatsapp/core/resources/widgets/file_picker.dart';
import 'package:whatsapp/generated/l10n.dart';
import 'package:whatsapp/core/resources/widgets/messages_list.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String uid;
  final String username;
  const ChatScreen({super.key, required this.uid, required this.username});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<UserInfoEntity>(
            stream: ref.watch(userInfoViewmodelProvider).getUserById(widget.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.username),
                  Text(
                    snapshot.data!.isOnline ? strings.online : strings.offline,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned.fill(
              child: AppAssetImage(
            AppImages.chatScreenBackground,
            color: Color(0xFFf0e8de),
          )),
          Column(
            children: [
              Expanded(
                child: Messages(receiverId: widget.uid),
              ),
              BottomChatField(receiverId: widget.uid, messageCtrl: messageController),
            ],
          ),
        ],
      ),
    );
  }
}

final isWroteProvider = StateProvider<bool>((ref) => false);

class BottomChatField extends ConsumerWidget {
  const BottomChatField({
    required this.messageCtrl,
    required this.receiverId,
    Key? key,
  }) : super(key: key);
  final TextEditingController messageCtrl;
  final String receiverId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = S.of(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: AppColors.colors.black.withOpacity(.05),
                  offset: const Offset(1, -1),
                  blurRadius: 30,
                ),
                BoxShadow(
                  color: AppColors.colors.black.withOpacity(.05),
                  offset: const Offset(-1, 1),
                  blurRadius: 30,
                ),
              ]),
              child: TextFormField(
                controller: messageCtrl,
                onChanged: (value) {
                  if (value.isEmpty && messageCtrl.text.isEmpty) {
                    ref.read(isWroteProvider.notifier).state = false;
                  } else {
                    ref.read(isWroteProvider.notifier).state = true;
                  }
                },
                maxLines: 6,
                minLines: 1,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.colors.neutral45,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: size.width * .07,
                        child: IconButton(
                          splashColor: AppColors.colors.transparent,
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.emoji_emotions,
                            color: AppColors.colors.neutral14,
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: SizedBox(
                        width: size.width * .25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              splashColor: AppColors.colors.transparent,
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(6),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => SelectMessageTypeDialog(receiverId),
                                  barrierColor: AppColors.colors.transparent,
                                );
                              },
                              icon: Transform.rotate(
                                angle: -30 * math.pi / 180,
                                child: Icon(
                                  Icons.attach_file,
                                  color: AppColors.colors.neutral14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.only(left: 6),
                              splashColor: AppColors.colors.transparent,
                              onPressed: () async {
                                final image = await pickImageFromGallery(ImageSource.gallery);
                                if (image != null) {
                                  ref.read(chatViewmodelProvider).sendFileMessage(
                                        FileMessageParams(
                                          receiverId: receiverId,
                                          messageType: MessageType.image,
                                          file: File(image.path),
                                        ),
                                      );
                                }
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: AppColors.colors.neutral14,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                    hintText: strings.bottomChatFieldHint,
                    hintStyle: TextStyle(color: AppColors.colors.neutral14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: GestureDetector(
              onTap: () async {
                if (ref.read(isWroteProvider)) {
                  final state = await ref.read(chatViewmodelProvider).sendTextMessage(TextMessageParams(
                        receiverId: receiverId,
                        text: messageCtrl.text.trim(),
                      ));

                  state.when(
                    loading: () {
                      //TODO:
                    },
                    data: (data) {
                      //TODO:
                    },
                    error: (err) {
                      //TODO:
                    },
                  );
                  messageCtrl.clear();

                  ref.read(isWroteProvider.notifier).state = false;
                } else {
                  // Implement send audio to user here
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colors.primary,
                ),
                child: Icon(
                  ref.watch(isWroteProvider) ? Icons.send_rounded : Icons.mic_sharp,
                  color: AppColors.colors.white,
                  size: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
                _FileTypeWidget(
                  typeName: strings.docFileTypeName,
                  icon: Icons.file_present_rounded,
                  background: const Color.fromARGB(255, 202, 97, 250),
                  onPressed: () {},
                ),
                _FileTypeWidget(
                  typeName: strings.cameraFileTypeName,
                  icon: Icons.camera_alt,
                  background: const Color.fromARGB(255, 254, 46, 116),
                  onPressed: () async {
                    // final image = await pickVideoFromGallery().then((value) {
                    //   Navigator.pop(context);
                    //   return value;
                    // });

                    // if (image != null) {
                    //   await ref.read(chatViewmodelProvider).sendFileMessage(
                    //         FileMessageParams(
                    //           receiverId: receiverId,
                    //           messageType: MessageType.video,
                    //           file: File(image.path),
                    //         ),
                    //       );
                    // }
                  },
                ),
                _FileTypeWidget(
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
                _FileTypeWidget(
                  typeName: strings.contactFileTypeName,
                  icon: Icons.person,
                  background: const Color.fromARGB(255, 1, 157, 225),
                  onPressed: () {},
                ),
                _FileTypeWidget(
                  typeName: strings.locationFileTypeName,
                  icon: Icons.location_on_outlined,
                  background: const Color.fromARGB(255, 29, 166, 84),
                  onPressed: () {},
                ),
                _FileTypeWidget(
                  typeName: strings.audioFileTypeName,
                  icon: Icons.headphones_outlined,
                  background: const Color.fromARGB(255, 250, 101, 51),
                  onPressed: () {},
                ),
                _FileTypeWidget(
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

class _FileTypeWidget extends StatelessWidget {
  final String typeName;
  final IconData icon;
  final Color background;
  final VoidCallback onPressed;
  const _FileTypeWidget(
      {super.key, required this.typeName, required this.icon, required this.background, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50 / 2), color: background),
            child: Center(child: Icon(icon, color: AppColors.colors.white, size: 24)),
          ),
          const SizedBox(height: 6),
          Text(
            typeName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.colors.neutral14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
