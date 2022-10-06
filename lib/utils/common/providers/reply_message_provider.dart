import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../enums/message_type.dart';

final replyMessageProvider = StateProvider<ReplyMessage?>((ref) => null);

class ReplyMessage {
  ReplyMessage({
    required this.message,
    required this.isMe,
    required this.messageType,
    required this.isSender,
  });
  final String message;
  final bool isMe;
  final MessageType messageType;
  final bool isSender;
}
