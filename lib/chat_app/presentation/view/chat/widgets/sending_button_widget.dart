import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/bottom_chat_filed.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

class SendingButtonWidget extends ConsumerWidget {
  const SendingButtonWidget({
    super.key,
    this.onTap,
    this.onLongPress,
    this.onLongPressCancel,
  });
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onLongPressCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: GestureDetector(
        onLongPress: onLongPress,
        onLongPressCancel: onLongPressCancel,
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ref.watch(isRecording) ? AppColors.colors.danger : AppColors.colors.primary,
          ),
          child: Icon(
            ref.watch(isWroteProvider)
                ? Icons.send_rounded
                : ref.watch(isRecording)
                    ? Icons.close
                    : Icons.mic_sharp,
            color: AppColors.colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
