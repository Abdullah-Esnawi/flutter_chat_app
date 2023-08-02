import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/presentation/view/call/calling_pickup_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/bottom_chat_filed.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/calling_viewmodel.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';
import 'package:whatsapp/generated/l10n.dart';
import 'package:whatsapp/core/resources/widgets/messages_list.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String uid;
  final String username;
  final String? profilePic;
  const ChatScreen({super.key, required this.uid, required this.username, this.profilePic});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
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
                  Text(widget.username.isEmpty ? snapshot.data!.phoneNumber : widget.username),
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
            onPressed: () {
              ref
                  .read(callingViewmodelProvider)
                  .makeCall(receiverId: widget.uid, receiverName: widget.username, receiverPic: widget.profilePic);
            },
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
              // RecordingMic(receiverId: widget.uid),
            ],
          ),
        ],
      ),
    );
  }
}
