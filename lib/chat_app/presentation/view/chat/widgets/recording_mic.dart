// import 'dart:io';

// import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:whatsapp/chat_app/di_module/module.dart';
// import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
// import 'package:whatsapp/chat_app/presentation/view/chat/widgets/bottom_chat_filed.dart';
// import 'package:whatsapp/core/resources/enums.dart';

// import 'recording_mic_widget.dart';

// class RecordingMic extends ConsumerStatefulWidget {
//   final String receiverId;
//   const RecordingMic({
//     super.key,
//     required this.receiverId,
//   });

//   @override
//   ConsumerState<RecordingMic> createState() => _RecordingMicState();
// }

// class _RecordingMicState extends ConsumerState<RecordingMic> {
//   late final RecorderController recorderController;

//   @override
//   void initState() {
//     super.initState();
//     recorderController = RecorderController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: ref.watch(isRecording),
//       child: RecordingMicWidget(
//         onVerticalScrollComplete: () {},
//         onHorizontalScrollComplete: () {
//           cancelRecord();
//         },
//         onLongPress: () {
//           startRecording();
//         },
//         onLongPressCancel: () {
//           stopRecording();
//         },
//         onSend: () {
//           stopRecording();
//         },
//         onTapCancel: () {
//           cancelRecord();
//         },
//       ),
//     );
//   }

//   void startRecording() async {
//     if (await recorderController.checkPermission()) {
//       await recorderController.record();
//     }
//   }

//   void cancelRecord() async {
//     await recorderController.stop();
//   }

//   void stopRecording() async {
//     final path = await recorderController.stop();
//     ref.read(chatViewmodelProvider).sendFileMessage(
//           FileMessageParams(receiverId: widget.receiverId, messageType: MessageType.audio, file: File(path!)),
//         );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     recorderController.dispose();
//   }
// }
