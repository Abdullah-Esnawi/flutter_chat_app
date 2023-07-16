import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.content, required this.messageType});
  final String content;
  final MessageType messageType;
  @override
  Widget build(BuildContext context) {
    final Widget messageWidget;
    switch (messageType) {
      case MessageType.text:
        messageWidget = Text(content, style: TextStyle(fontSize: 16, color: AppColors.colors.white));
        break;
      case MessageType.image:
        messageWidget = AppCachedImage(url: content, borderRadius: BorderRadius.circular(6));
        break;

      case MessageType.gif:
        messageWidget = Container();
        break;

      case MessageType.video:
        messageWidget = Container();
        break;

      case MessageType.audio:
        messageWidget = Container();
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
      child: messageWidget,
    );
  }
}
