import 'package:flutter/material.dart';
import '../data/info.dart';
import 'message_card.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (messages[index]['isMe'] == true) {
          return MessageCard(
            isSender: true,
            message: messages[index]['text'].toString(),
            time: messages[index]['time'].toString(),
          );
        } else {
          return MessageCard(
            isSender: false,
            message: messages[index]['text'].toString(),
            time: messages[index]['time'].toString(),
          );
        }
      },
    );
  }
}
