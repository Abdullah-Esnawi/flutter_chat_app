import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/chat_viewmodel.dart';
import 'package:whatsapp/core/resources/widgets/error.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';
import 'package:whatsapp/core/resources/widgets/my_message_card.dart';
import 'package:whatsapp/core/resources/widgets/sender_message_card.dart';

class Messages extends ConsumerWidget {
  final String receiverId;
  Messages({required this.receiverId, Key? key}) : super(key: key);
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getChatMessagesStreamProvider(receiverId)).when(
        data: (messages) {
          /// Scroll Down
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _controller.jumpTo(_controller.position.maxScrollExtent);
          });
          return ListView.builder(
            controller: _controller,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              if (messages[index].senderId == FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(messages[index]);
              }
              return SenderMessageCard(messages[index]);
            },
          );
        },
        error: (error, stack) => WidgetError(
            message: error.toString(),
            tryAgain: () {
              Navigator.pop(context);
              // ref.watch(getChatMessagesStreamProvider(receiverId));
            }),
        loading: () => const Loader());
  }
}
