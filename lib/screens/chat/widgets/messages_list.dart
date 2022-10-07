import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../models/message.dart';
import '../../../utils/common/enums/message_type.dart';
import '../../../utils/common/enums/swipe_direction.dart';
import '../../../utils/common/providers/reply_message_provider.dart';
import '../controllers/chat_controller.dart';
import '../../../utils/common/providers/current_user_provider.dart';
import '../../../utils/common/widgets/loader.dart';
import 'message_card.dart';

class MessagesList extends ConsumerStatefulWidget {
  const MessagesList({
    super.key,
    required this.receiverUserId,
  });

  final String receiverUserId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends ConsumerState<MessagesList> {
  late final ScrollController _messagesScrollController;

  @override
  void initState() {
    super.initState();
    _messagesScrollController = ScrollController();
  }

  @override
  void dispose() {
    _messagesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: ref
          .watch(chatControllerProvider)
          .getMessagesList(receiverUserId: widget.receiverUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Loader();
        }

        // adding callback to new message to scroll to bottom.
        SchedulerBinding.instance.addPostFrameCallback(
          (_) => _messagesScrollController.animateTo(
            _messagesScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          ),
        );

        return ListView.builder(
          controller: _messagesScrollController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Message message = snapshot.data![index];

            final bool isSenderUser =
                message.senderUserId == ref.read(currentUserProvider!).uid;
            return MessageCard(
              isSender: isSenderUser ? true : false,
              message: message.lastMessage,
              messageType: message.messageType,
              time: DateFormat.Hm().format(message.time),
              onSwipe: isSenderUser
                  ? () => _onSwipeMessage(
                        message: message.lastMessage,
                        isMe: true,
                        messageType: message.messageType,
                        isSender: true,
                      )
                  : () => _onSwipeMessage(
                        message: message.lastMessage,
                        isMe: false,
                        messageType: message.messageType,
                        isSender: false,
                      ),
              swipeDirection:
                  isSenderUser ? SwipeDirection.left : SwipeDirection.right,
              repliedText: message.repliedMessage,
              repliedMessageType: message.repliedMessageType,
              username: message.repliedTo,
            );
          },
        );
      },
    );
  }

  void _onSwipeMessage({
    required String message,
    required bool isMe,
    required MessageType messageType,
    required bool isSender,
  }) {
    ref.watch(replyMessageProvider.state).state = ReplyMessage(
      message: message,
      isMe: isMe,
      messageType: messageType,
      isSender: isSender,
    );
  }
}
