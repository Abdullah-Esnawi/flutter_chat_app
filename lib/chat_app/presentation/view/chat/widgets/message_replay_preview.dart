import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/generated/l10n.dart';

class MessageReplayWidget extends ConsumerWidget {
  const MessageReplayWidget({
    super.key,
    required this.messageReplay,
    required this.isPreviewMode,
    this.onCloseTap,
  });
  final MessageReplay messageReplay;
  final VoidCallback? onCloseTap;
  final bool isPreviewMode;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      width: MediaQuery.of(context).size.width * .86,
      padding: isPreviewMode ? const EdgeInsets.all(8) : null,
      decoration: isPreviewMode
          ? BoxDecoration(
              color: (messageReplay.isMe && !isPreviewMode) ? AppColors.colors.neutral75 : AppColors.colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            )
          : null,
      child: Container(
        // height: 0,
        padding: const EdgeInsetsDirectional.only(start: 10, bottom: 6, end: 6, top: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(stops: const [
            0.017,
            0.017
          ], colors: [
            AppColors.colors.primary,
            isPreviewMode ? AppColors.colors.black.withOpacity(.1) : AppColors.colors.white.withAlpha(120),
          ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  messageReplay.isMe
                      ? S.of(context).you
                      : messageReplay.repliedTo.isEmpty
                          ? "Opposite"
                          : messageReplay.repliedTo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.colors.primary,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
                if (isPreviewMode)
                  GestureDetector(
                    onTap: onCloseTap,
                    child: const Icon(Icons.close, size: 16),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              messageReplay.messageType == MessageType.text
                  ? messageReplay.message
                  : messageReplay.messageType.name
                      .replaceFirst(messageReplay.messageType.name[0], messageReplay.messageType.name[0].toUpperCase()),
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.colors.neutral14),
            ),
          ],
        ),
      ),
    );
  }
}
