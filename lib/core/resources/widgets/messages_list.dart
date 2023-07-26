import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/chat_viewmodel.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/resources/widgets/error.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';
import 'package:whatsapp/core/resources/widgets/my_message_card.dart';
import 'package:whatsapp/core/resources/widgets/sender_message_card.dart';

class Messages extends ConsumerStatefulWidget {
  final String receiverId;
  Messages({required this.receiverId, Key? key}) : super(key: key);

  @override
  ConsumerState<Messages> createState() => _MessagesState();
}

class _MessagesState extends ConsumerState<Messages> {
  final ScrollController _controller = ScrollController();
  void onMessageSwipe(MessageReplay messageReplay) {
    ref.read(messageReplayProvider.notifier).update((state) => messageReplay);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getChatMessagesStreamProvider(widget.receiverId)).when(
        data: (messages) {
          /// Scroll Down
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _controller.jumpTo(_controller.position.maxScrollExtent);
          });
          return ListView.builder(
            cacheExtent: 999999,
            controller: _controller,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              if (messages[index].senderId == FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  messages[index],
                  onLeftSwipe: () => onMessageSwipe(
                    MessageReplay(
                      message: messages[index].text,
                      isMe: true,
                      messageType: messages[index].messageType,
                      repliedTo: messages[index].repliedTo,
                    ),
                  ),
                );
              }
              return SenderMessageCard(
                messages[index],
                onRightSwipe: () => onMessageSwipe(
                  MessageReplay(
                    message: messages[index].text,
                    isMe: false,
                    messageType: messages[index].messageType,
                    repliedTo: messages[index].senderName,
                  ),
                ),
              );
            },
          );
        },
        error: (error, stack) => WidgetError(
            message: error.toString(),
            tryAgain: () {
              // Navigator.pop(context);
              ref.watch(getChatMessagesStreamProvider(widget.receiverId));
            }),
        loading: () => const Loader());
  }
}
