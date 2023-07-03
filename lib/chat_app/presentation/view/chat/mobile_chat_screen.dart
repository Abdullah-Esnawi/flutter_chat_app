import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/chat_viewmodel.dart';
import 'package:whatsapp/core/resources/colors.dart';
import 'package:whatsapp/generated/l10n.dart';
import 'package:whatsapp/core/resources/widgets/chat_list.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({Key? key, required this.uid, required this.username}) : super(key: key);
  final String uid;
  final String username;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = S.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserInfoEntity>(
            stream: ref.watch(userInfoViewmodelProvider).getUserById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username),
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
          const Expanded(
            child: Messages(),
          ),
          BottomChatField(receiverId: uid),
        ],
      ),
    );
  }
}

final isWroteProvider = StateProvider<bool>((ref) => false);

class BottomChatField extends ConsumerStatefulWidget {
  const BottomChatField({
    required this.receiverId,
    Key? key,
  }) : super(key: key);

  final String receiverId;

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  final messageCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            onPressed: () {},
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
                  // Implement send message to user here
                  debugPrint(messageCtrl.text);

                  final state = await ref.read(chatViewmodelProvider).sendTextMessage(TextMessageParams(
                        receiverId: widget.receiverId,
                        text: messageCtrl.text.trim(),
                      ));

                  state.when(
                    loading: () {
                      //TODO:
                      messageCtrl.clear();
                    },
                    data: (data) {
                      messageCtrl.clear();
                      //TODO:
                    },
                    error: (err) {
                      //TODO:
                      messageCtrl.clear();
                    },
                  );
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
