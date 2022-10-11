import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
