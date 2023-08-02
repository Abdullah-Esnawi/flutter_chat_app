import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/chat_app/domain/entities/call_entity.dart';
import 'package:whatsapp/core/config/agora_config.dart';

class CallScreen extends StatefulWidget {
  final String channelId;
  final CallEntity call;
  // final bool isGroupChat;
  const CallScreen({super.key, required this.channelId, required this.call});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  AgoraClient? client;

  @override
  void initState() {
    super.initState();
    client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
      appId: AgoraConfig.appId,
      channelName: widget.channelId,
      tokenUrl: AgoraConfig.token,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
