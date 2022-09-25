import 'package:flutter/material.dart';
import 'package:lets_chat/utils/info.dart';
import 'package:lets_chat/utils/routes_constants.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: info.length,
      itemBuilder: (context, index) {
        return _buildChatListItem(context, index);
      },
    );
  }

  Widget _buildChatListItem(BuildContext context, int index) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, AppRoutes.chatScreen),
      title: Text(
        info[index]['name'].toString(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        info[index]['message'].toString(),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
          info[index]['profilePic'].toString(),
        ),
      ),
      trailing: Text(
        info[index]['time'].toString(),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
