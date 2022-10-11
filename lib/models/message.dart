import '../utils/common/enums/message_type.dart';

class Message {
  Message({
    required this.senderUserId,
    required this.receiverUserId,
    required this.messageId,
    required this.isSeen,
    required this.lastMessage,
    required this.messageType,
    required this.time,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  final String senderUserId;
  final String receiverUserId;
  final String messageId;
  final bool isSeen;
  final String lastMessage;
  final MessageType messageType;
  final DateTime time;
  final String repliedMessage;
  final String repliedTo;
  final MessageType repliedMessageType;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderUserId': senderUserId,
      'receiverUserId': receiverUserId,
      'messageId': messageId,
      'isSeen': isSeen,
      'lastMessage': lastMessage,
      'messageType': messageType.type,
      'time': time.millisecondsSinceEpoch,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderUserId: map['senderUserId'] as String,
      receiverUserId: map['receiverUserId'] as String,
      messageId: map['messageId'] as String,
      isSeen: map['isSeen'] as bool,
      lastMessage: map['lastMessage'] as String,
      messageType: (map['messageType'] as String).toEnum(),
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      repliedMessage: map['repliedMessage'] as String,
      repliedTo: map['repliedTo'] as String,
      repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
    );
  }
}
