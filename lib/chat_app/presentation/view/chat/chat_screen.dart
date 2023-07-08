import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/core/resources/colors.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/resources/widgets/image_picker.dart';
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
        backgroundColor: appBarColor,
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
      body: Column(
        children: [
          Expanded(
            child: Messages(receiverId: widget.uid),
          ),
          BottomChatField(receiverId: widget.uid, messageCtrl: messageController),
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

  // final messageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = S.of(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageCtrl,
              onChanged: (value) {
                if (value.isEmpty && messageCtrl.text.isEmpty) {
                  ref.read(isWroteProvider.notifier).state = false;
                } else {
                  ref.read(isWroteProvider.notifier).state = true;
                }
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: size.width * .07,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: SizedBox(
                      width: size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            splashColor: Colors.transparent,
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(6),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.only(left: 6),
                            splashColor: Colors.transparent,
                            onPressed: () async {
                              final image = await pickImageFromGallery(context);
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
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  hintText: strings.bottomChatFieldHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(54.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(0)),
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: tabColor,
                ),
                child: Icon(
                  ref.watch(isWroteProvider) ? Icons.send_rounded : Icons.mic_sharp,
                  color: Colors.white,
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
