import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/message.dart';
import '../../screens/chat/controllers/chat_controller.dart';
import '../common/providers/current_user_provider.dart';
import '../common/widgets/loader.dart';
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

            if (message.senderUserId == ref.read(currentUserProvider!).uid) {
              return MessageCard(
                isSender: true,
                message: message.lastMessage,
                messageType: message.messageType,
                time: DateFormat.Hm().format(message.time),
              );
            }
            return MessageCard(
              isSender: false,
              message: message.lastMessage,
              messageType: message.messageType,
              time: DateFormat.Hm().format(message.time),
            );
          },
        );
      },
    );
  }
}
