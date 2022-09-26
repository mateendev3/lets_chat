import 'package:flutter/material.dart';
import 'package:lets_chat/screens/widgets/messages_list.dart';
import 'package:lets_chat/utils/colors_constants.dart';
import 'package:lets_chat/utils/helper_widgets.dart';
import 'package:lets_chat/utils/info.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      backgroundColor: AppColors.scaffoldBGChat,
    );
  }

  Center _buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Expanded(
            child: MessagesList(),
          ),
          buildMessageTF(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leadingWidth: 32.0,
      elevation: 0.3,
      backgroundColor: AppColors.chatAppBar,
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: AppColors.chatScreenGrey,
          ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              info[0]['profilePic'].toString(),
            ),
          ),
          addHorizontalSpace(12.0),
          const Text(
            'Mateen',
            style: TextStyle(
              color: AppColors.lightBlack,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0.0),
          icon: const Icon(
            Icons.phone_outlined,
            color: AppColors.chatScreenGrey,
          ),
        ),
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0.0),
          icon: const Icon(
            Icons.videocam_outlined,
            color: AppColors.chatScreenGrey,
          ),
        ),
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0.0),
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.chatScreenGrey,
          ),
        ),
      ],
    );
  }

  Widget buildMessageTF(BuildContext context) {
    return Container(
      color: AppColors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        minLines: 1,
        maxLines: 6,
        keyboardType: TextInputType.multiline,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.chatTFFill,
          prefixIcon: const Icon(
            Icons.emoji_emotions_outlined,
            color: AppColors.chatScreenGrey,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.attach_file_outlined,
                  color: AppColors.chatScreenGrey,
                ),
                addHorizontalSpace(12.0),
                const Icon(
                  Icons.camera,
                  color: AppColors.chatScreenGrey,
                ),
              ],
            ),
          ),
          hintText: 'Type a message...',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.chatScreenGrey,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding: const EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
