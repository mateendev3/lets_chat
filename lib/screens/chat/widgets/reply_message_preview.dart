import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_chat/screens/chat/widgets/display_message.dart';
import 'package:lets_chat/utils/common/providers/reply_message_provider.dart';
import 'package:lets_chat/utils/common/widgets/helper_widgets.dart';

class ReplyMessagePreview extends ConsumerWidget {
  const ReplyMessagePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ReplyMessage? replyMessage = ref.watch(replyMessageProvider);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  replyMessage!.isMe ? 'Me' : 'Opposite',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.close))
            ],
          ),
          addVerticalSpace(8.0),
          DisplayMessage(
            message: replyMessage.message,
            messageType: replyMessage.messageType,
            isSender: replyMessage.isMe,
          ),
        ],
      ),
    );
  }

  void cancelReply(WidgetRef ref) {
    //Todo : maybe error.
    ref.read(replyMessageProvider.state).state = null;
  }
}
