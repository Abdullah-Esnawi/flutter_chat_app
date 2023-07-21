import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/bottom_chat_filed.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

class EmojiPickerWidget extends ConsumerWidget {
  final TextEditingController messageController;
  final VoidCallback onGifButtonTap;

  const EmojiPickerWidget({
    super.key,
    required this.onGifButtonTap,
    required this.messageController,
  });
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EmojiPicker(
            onEmojiSelected: (category, emoji) {
              ref.read(isWroteProvider.notifier).state = true;
            },
            onBackspacePressed: () {
              messageController.text.trimRight();
            },
            textEditingController: messageController,
            config: Config(
              columns: 8,
              iconColorSelected: AppColors.colors.primary,
              indicatorColor: AppColors.colors.primary,
              backspaceColor: AppColors.colors.primary,
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onGifButtonTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    child: const Icon(
                      Icons.gif,
                      size: 30,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
