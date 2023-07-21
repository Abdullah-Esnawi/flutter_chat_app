import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/widgets/message_widget.dart';

class MyMessageCard extends StatelessWidget {
  final Message message;

  const MyMessageCard(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
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
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              MessageWidget(content: message.text, messageType: message.messageType),
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
    );
  }
}
