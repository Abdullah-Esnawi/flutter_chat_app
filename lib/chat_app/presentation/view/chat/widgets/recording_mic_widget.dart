// import 'package:flutter/material.dart';
// import 'package:whatsapp/chat_app/presentation/view/chat/widgets/bottom_chat_filed.dart';
// import 'package:whatsapp/chat_app/presentation/view/chat/widgets/sending_button_widget.dart';
// // import 'package:whatsapp/chat_app/presentation/view/chat/widgets/send_button_widget';
// import 'package:whatsapp/core/resources/colors_manager.dart';
// import 'package:whatsapp/generated/l10n.dart';

// class RecordingWidget extends StatefulWidget {
//   const RecordingWidget({super.key});

//   @override
//   State<RecordingWidget> createState() => _RecordingWidgetState();
// }

// class _RecordingWidgetState extends State<RecordingWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return StreamBuilder(builder: (context, snapshot) {
//       return Container(
//         height: 160,
//         width: size.width,
//         color: AppColors.colors.white,
//         padding: const EdgeInsets.all(18),
//         child: Column(children: [
//           const Row(
//             children: [
//               Text('00:35')
//               //TODO: Create record chart widget
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
//               IconButton(onPressed: () {}, icon: Icon(Icons.pause_circle_outline)),
//              const SendingButtonWidget(),

//               ///
//             ],
//           )
//         ]),
//       );
//     });
//   }
// }
