import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/message_replay_preview.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/widgets/message_widget.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard(this.message, {super.key, required this.onRightSwipe});
  final VoidCallback onRightSwipe;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
            maxHeight: 400,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: AppColors.colors.neutral45,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // TODO: Complete this
                // if (message.repliedMessage.isNotEmpty)
                //   MessageReplayWidget(
                //       messageReplay: MessageReplay(
                //     isMe: message.senderId == FirebaseAuth.instance.currentUser!.uid,
                //     message: message.repliedMessage,
                //     messageType: message.repliedMessageType!,
                //     repliedTo: message.repliedTo,
                //   )),
                MessageWidget(
                  content: message.text,
                  messageType: message.messageType,
                  messageReplay: message.repliedMessage.isNotEmpty
                      ? MessageReplay(
                          message: message.text,
                          isMe: false,
                          messageType: message.repliedMessageType!,
                          repliedTo: message.repliedTo,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Text(
                    DateFormat('hh:mm a').format(message.timeSent),
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.colors.neutral55,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
