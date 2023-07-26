import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/message_replay_preview.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/resources/widgets/message_widget.dart';

class MyMessageCard extends StatelessWidget {
  final Message message;
  final VoidCallback onLeftSwipe;
  const MyMessageCard(this.message, {super.key, required this.onLeftSwipe});

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe: onLeftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          // child: ColoredBox(
          // color: message.repliedMessage.isNotEmpty ? AppColors.colors.white : AppColors.colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,
              maxHeight: 400,
              minWidth: 136,
            ),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color: AppColors.colors.neutral75,
              margin:
                  EdgeInsets.only(left: 15, right: 15, bottom: 5, top: /*message.repliedMessage.isNotEmpty ? 65 : */ 5),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // // TODO: Complete this
                  // if (message.repliedMessage.isNotEmpty)
                  //   Positioned(
                  //     top: -65,
                  //     child: MessageReplayWidget(
                  //         messageReplay: MessageReplay(
                  //       isMe: true,
                  //       message: message.repliedMessage,
                  //       messageType: message.repliedMessageType!,
                  //       repliedTo: message.senderName,
                  //     )),
                  //   ),
                  MessageWidget(
                    content: message.text,
                    messageType: message.messageType,
                    messageReplay: message.repliedMessage.isNotEmpty
                        ? MessageReplay(
                            message: message.text,
                            isMe: true,
                            messageType: message.repliedMessageType!,
                            repliedTo: message.repliedTo,
                          )
                        : null,
                  ),
                  PositionedDirectional(
                    bottom: 4,
                    start: 10,
                    end: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('hh:mm a').format(message.timeSent),
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.colors.neutral55,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.done_all,
                          size: 20,
                          color: AppColors.colors.neutral55,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ),
        ),
      ),
    );
  }
}
