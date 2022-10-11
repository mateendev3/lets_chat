import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/call.dart';
import '../../../utils/common/config/agora_config.dart';
import '../../../utils/common/widgets/loader.dart';
import '../../../utils/constants/colors_constants.dart';
import '../controllers/call_controller.dart';

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
        appId: AgoraConfig.appId,
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
                  AgoraVideoButtons(
                    client: client!,
                    disconnectButtonChild: IconButton(
                      color: AppColors.white,
                      iconSize: 56.0,
                      onPressed: () async {
                        await client!.engine.leaveChannel();
                        if (!mounted) return;
                        ref.read(callControllerProvider).endCall(
                              context,
                              callerId: widget.call.callerId,
                              receiverId: widget.call.receiverId,
                            );
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.call_end,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void initAgora() async {
    await client!.initialize();
  }
}
