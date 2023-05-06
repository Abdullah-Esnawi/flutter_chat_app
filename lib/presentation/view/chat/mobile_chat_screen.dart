import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/resources/colors.dart';
import 'package:whatsapp/generated/l10n.dart';
import 'package:whatsapp/info.dart';
import 'package:whatsapp/presentation/common/widgets/chat_list.dart';
import 'package:whatsapp/presentation/common/widgets/loader.dart';
import 'package:whatsapp/presentation/viewmodel/user_info_viewmodel.dart';

import '../../../domain/entities/user_entities.dart';

class MobileChatScreen extends ConsumerWidget {
  const MobileChatScreen({Key? key, required this.uid, required this.username}) : super(key: key);
  final String uid;
  final String username;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = S.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserInfo>(
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
                    snapshot.data!.isOnline! ? strings.online : strings.offline,
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
            child: ChatList(),
          ),
          BottomChatField(),
        ],
      ),
    );
  }
}

final isWroteProvider = StateProvider<bool>((ref) => false);

class BottomChatField extends ConsumerWidget {
  const BottomChatField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: TextField(
      
            style: TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.gif,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.attach_file,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              hintText: 'Type a message!',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              if (ref.read(isWroteProvider)) {
                // Implement send message to user here
              } else {
                // Implement send audio to user here
              }
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: tabColor,
              child: Icon(ref.watch(isWroteProvider) ? Icons.send : Icons.mic_sharp, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
