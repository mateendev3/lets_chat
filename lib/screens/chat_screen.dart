import 'package:flutter/material.dart';
import '../utils/constants/colors_constants.dart';
import '../utils/common/helper_widgets.dart';
import '../utils/data/info.dart';
import '../utils/widgets/messages_list.dart';

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
      elevation: 1,
      shadowColor: AppColors.white,
      backgroundColor: AppColors.chatAppBar,
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: AppColors.primary,
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
            color: AppColors.primary,
          ),
        ),
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0.0),
          icon: const Icon(
            Icons.videocam_outlined,
            color: AppColors.primary,
          ),
        ),
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0.0),
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget buildMessageTF(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(-2, -2),
              blurRadius: 3,
              spreadRadius: 1),
        ],
      ),
      child: TextField(
        minLines: 1,
        maxLines: 6,
        keyboardType: TextInputType.multiline,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.chatTFFill,
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
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
        ),
      ),
    );
  }
}
