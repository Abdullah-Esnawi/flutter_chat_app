import 'dart:io';
import 'dart:math' as math;

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_gif_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/emoji_picker_widget.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/message_replay_preview.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/select_message_type_dialog.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/widgets/sending_button_widget.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:whatsapp/core/resources/widgets/file_picker.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';
import 'package:whatsapp/generated/l10n.dart';

final isWroteProvider = StateProvider.autoDispose<bool>((ref) => false);
final isEmojiAppeared = StateProvider.autoDispose<bool>((ref) => false);
final isRecording = StateProvider.autoDispose<bool>((ref) => false);

class BottomChatField extends ConsumerStatefulWidget {
  const BottomChatField({
    required this.messageCtrl,
    required this.receiverId,
    Key? key,
  }) : super(key: key);
  final TextEditingController messageCtrl;
  final String receiverId;

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  RecorderController recorderController = RecorderController();

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    recorderController.checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final size = MediaQuery.of(context).size;
    final messageReplay = ref.watch(messageReplayProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Message Replay Preview
          // if (messageReplay != null)
          //   MessageReplayWidget(
          //     isPreviewMode: true,
          //     messageReplay: messageReplay,
          //     onCloseTap: () {
          //       ref.read(messageReplayProvider.notifier).update((state) => null);
          //     },
          //   ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.colors.black.withOpacity(.05),
                        offset: const Offset(1, -1),
                        blurRadius: 30,
                      ),
                      BoxShadow(
                        color: AppColors.colors.black.withOpacity(.05),
                        offset: const Offset(-1, 1),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (messageReplay != null)
                        MessageReplayWidget(
                          isPreviewMode: true,
                          messageReplay: messageReplay,
                          onCloseTap: () {
                            ref.read(messageReplayProvider.notifier).update((state) => null);
                          },
                        ),
                      TextFormField(
                        focusNode: focusNode,
                        controller: widget.messageCtrl,
                        onChanged: (value) {
                          if ((value.isEmpty && widget.messageCtrl.text.isEmpty)) {
                            ref.read(isWroteProvider.notifier).state = false;
                          } else {
                            ref.read(isWroteProvider.notifier).state = true;
                          }
                        },
                        onTap: () {
                          ref.read(isEmojiAppeared.notifier).state = false;
                        },
                        style: TextStyle(color: AppColors.colors.neutral11),
                        maxLines: 6,
                        minLines: 1,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.colors.neutral45,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                width: size.width * .07,
                                child: IconButton(
                                  splashColor: AppColors.colors.transparent,
                                  constraints: const BoxConstraints(),
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    if (!ref.read(isEmojiAppeared)) {
                                      ref.read(isEmojiAppeared.notifier).state = true;
                                      // Hide keyboard
                                      focusNode.unfocus();
                                    } else {
                                      ref.read(isEmojiAppeared.notifier).state = false;
                                      // Show keyboard
                                      focusNode.requestFocus();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.emoji_emotions,
                                    color: AppColors.colors.neutral14,
                                  ),
                                ),
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0),
                              child: SizedBox(
                                width: size.width * .25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      splashColor: AppColors.colors.transparent,
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.all(6),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => SelectMessageTypeDialog(widget.receiverId),
                                          barrierColor: AppColors.colors.transparent,
                                        );
                                      },
                                      icon: Transform.rotate(
                                        angle: -30 * math.pi / 180,
                                        child: Icon(
                                          Icons.attach_file,
                                          color: AppColors.colors.neutral14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.only(left: 6),
                                      splashColor: AppColors.colors.transparent,
                                      onPressed: () async {
                                        final image = await pickImageFromGallery(ImageSource.gallery);
                                        if (image != null) {
                                          ref.read(chatViewmodelProvider).sendFileMessage(
                                                FileMessageParams(
                                                  receiverId: widget.receiverId,
                                                  messageType: MessageType.image,
                                                  file: File(image.path),
                                                ),
                                              );
                                        }
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: AppColors.colors.neutral14,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                ),
                              ),
                            ),
                            hintText: strings.bottomChatFieldHint,
                            hintStyle: TextStyle(color: AppColors.colors.neutral14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(0)),
                      ),
                    ],
                  ),
                ),
              ),
              SendingButtonWidget(
                onTap: () async {
                  if (ref.read(isWroteProvider)) {
                    final state = await ref.read(chatViewmodelProvider).sendTextMessage(TextMessageParams(
                          receiverId: widget.receiverId,
                          text: widget.messageCtrl.text.trim(),
                          messageReplay: messageReplay != null
                              ? MessageReplay(
                                  message: messageReplay.message,
                                  isMe: messageReplay.isMe,
                                  messageType: messageReplay.messageType,
                                  repliedTo: messageReplay.repliedTo,
                                )
                              : null,
                        ));
                    // TODO: Handle message State
                    widget.messageCtrl.clear();

                    ref.read(isWroteProvider.notifier).state = false;
                  } else {
                    // await ref.read(chatViewmodelProvider).audioHandler(soundRecorder, widget.receiverId);
                    if (ref.read(isRecording)) {
                      var path = await recorderController.stop();
                      ref.read(isRecording.notifier).state = false;
                      if (path != null) {
                        await ref.read(chatViewmodelProvider).sendFileMessage(FileMessageParams(
                            receiverId: widget.receiverId, messageType: MessageType.audio, file: File(path)));
                      } else {
                        showSnackBar(content: strings.somethingWentWrong, duration: const Duration(seconds: 1));
                      }
                    } else {
                      showSnackBar(content: strings.recordToastMsg, duration: const Duration(seconds: 1));
                    }
                  }
                  ref.read(messageReplayProvider.notifier).update((state) => null);
                },
                onLongPress: () async {
                  if (recorderController.hasPermission) {
                    ref.read(isRecording.notifier).state = true;
                    await recorderController.record();
                  }
                },
              ),
            ],
          ),
          if (ref.watch(isEmojiAppeared))
            EmojiPickerWidget(
              messageController: widget.messageCtrl,
              onGifButtonTap: () {
                ref.read(chatViewmodelProvider).pickGif(context).then((gif) {
                  if (gif != null) {
                    ref
                        .read(chatViewmodelProvider)
                        .sendGifMessage(GifMessageParams(receiverId: widget.receiverId, gifUrl: gif.source!));
                  }
                });
              },
            ),
        ],
      ),
    );
  }
}
