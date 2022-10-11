import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_chat/utils/common/config/agora_config.dart';
import 'package:lets_chat/utils/common/widgets/loader.dart';
import '../../../models/call.dart';

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({
    required this.channelId,
    required this.call,
    required this.isGroupChat,
    Key? key,
  }) : super(key: key);
  final String channelId;
  final Call call;
  final bool isGroupChat;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  AgoraClient? client;

  @override
  void initState() {
    super.initState();

    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appCertificate,
        channelName: widget.channelId,
        tokenUrl: AgoraConfig.tokenBaseUrl,
      ),
    );

    initAgora();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Loader()
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(client: client!),
                  AgoraVideoButtons(client: client!),
                ],
              ),
            ),
    );
  }

  void initAgora() async {
    await client!.initialize();
  }
}
