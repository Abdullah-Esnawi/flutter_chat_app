import 'package:flutter/material.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/audio_player_widget.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/message_replay_preview.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';
import 'package:whatsapp/core/resources/widgets/chat_video_player_item.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.content, required this.messageType, this.messageReplay});
  final String content;
  final MessageType messageType;
  final MessageReplay? messageReplay;
  @override
  Widget build(BuildContext context) {
    final Widget messageWidget;
    switch (messageType) {
      case MessageType.text:
        messageWidget = Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.colors.neutral11,
          ),
          // maxLines: 30,
          textAlign: TextAlign.start,
        );
        break;
      case MessageType.image:
        messageWidget = AppCachedImage(
          url: content,
          borderRadius: BorderRadius.circular(6),
        );
        break;

      case MessageType.gif:
        int gifUrlPartIndex = content.lastIndexOf('-') + 1;
        String gifUrlPart = content.substring(gifUrlPartIndex);
        if (gifUrlPart.isEmpty || gifUrlPart == '/') {
          gifUrlPart = "contentNotAvailable";
        }
        String url = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
        messageWidget = AppCachedImage(url: url);
        break;

      case MessageType.video:
        messageWidget = VideoPlayerItem(videoUrl: content);
        break;

      case MessageType.audio:
        messageWidget = AudioPlayerWidget(url: content);
        break;

      case MessageType.location:
        messageWidget = Container();
        break;

      case MessageType.contact:
        messageWidget = Container();
        break;

      case MessageType.poll:
        messageWidget = Container();
        break;
    }

    return Padding(
      padding: messageType == MessageType.text
          ? const EdgeInsets.only(
              left: 10,
              right: 30,
              top: 4,
              bottom: 26,
            )
          : const EdgeInsets.only(
              left: 4,
              right: 4,
              top: 4,
              bottom: 26,
            ),
      child: messageReplay != null
          ? Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MessageReplayWidget(
                    messageReplay: messageReplay!,
                    isPreviewMode: false, //
                  ),
                  messageWidget,
                ],
              ),
            )
          : messageWidget,
    );
  }
}
