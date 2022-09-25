import 'package:flutter/material.dart';
import 'package:lets_chat/utils/colors_constants.dart';
import 'package:lets_chat/utils/helper_widgets.dart';
import 'package:lets_chat/utils/info.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColors.scaffoldBGChat,
      body: Center(
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              color: AppColors.white,
              height: kToolbarHeight + 16,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.chatTFFill,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.emoji_emotions,
                        color: AppColors.chatScreenGrey,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.camera_alt,
                            color: AppColors.chatScreenGrey,
                          ),
                          Icon(
                            Icons.attach_file,
                            color: AppColors.chatScreenGrey,
                          ),
                          Icon(
                            Icons.money,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Type a message!',
                    hintStyle: const TextStyle(
                      color: AppColors.lightBlack,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leadingWidth: 30.0,
      elevation: 0.3,
      backgroundColor: AppColors.chatAppBar,
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: AppColors.lightBlack,
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
          addHorizontalSpace(8.0),
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
          icon: const Icon(
            Icons.video_call_outlined,
            color: AppColors.chatScreenGrey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.call_outlined,
            color: AppColors.chatScreenGrey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_outlined,
            color: AppColors.chatScreenGrey,
          ),
        ),
      ],
    );
  }
}
