import 'package:flutter/material.dart';
import '../constants/routes_constants.dart';
import '../data/info.dart';

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
    Size size = MediaQuery.of(context).size;

    return ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.chatScreen,
        arguments: <String, Object>{
          'name': 'Mateen',
          'uid': '12345',
        },
      ),
      title: Text(
        info[index]['name'].toString(),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: size.width * 0.045,
            ),
      ),
      subtitle: Text(
        info[index]['message'].toString(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: size.width * 0.035,
            ),
      ),
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
          info[index]['profilePic'].toString(),
        ),
      ),
      trailing: Text(
        info[index]['time'].toString(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: size.width * 0.030,
            ),
      ),
    );
  }
}
