import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/chat.dart';
import '../../screens/chat/controllers/chat_controller.dart';
import '../../screens/chat/widgets/no_chat.dart';
import '../common/widgets/loader.dart';
import '../constants/routes_constants.dart';

class ChatsList extends ConsumerWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Chat>>(
      stream: ref.watch(chatControllerProvider).getChatsList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Loader();
        }
        return snapshot.data!.isEmpty
            ? const NoChat()
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Chat chat = snapshot.data![index];
                  return _buildChatListItem(context, index, chat);
                },
              );
      },
    );
  }

  Widget _buildChatListItem(BuildContext context, int index, Chat chat) {
    Size size = MediaQuery.of(context).size;

    return ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.chatScreen,
        arguments: <String, Object>{
          'receiverUsername': chat.name,
          'receiverUserId': chat.userId,
        },
      ),
      title: Text(
        chat.name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: size.width * 0.045,
            ),
      ),
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: size.width * 0.035,
            ),
      ),
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
          chat.profilePic,
        ),
      ),
      trailing: Text(
        DateFormat.Hm().format(chat.time),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: size.width * 0.030,
            ),
      ),
    );
  }
}
