import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/user.dart' as app;
import '../../../utils/common/widgets/loader.dart';
import '../../../utils/constants/colors_constants.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../auth/controllers/auth_controller.dart';
import '../widgets/messages_list.dart';
import '../widgets/bottom_chat_text_field.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late Map<String, Object> receiverUserData;

  @override
  Widget build(BuildContext context) {
    receiverUserData =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      backgroundColor: AppColors.scaffoldBGChat,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: MessagesList(
              receiverUserId: receiverUserData['receiverUserId'] as String,
            ),
          ),
          BottomChatTextField(
            receiverUserId: receiverUserData['receiverUserId'] as String,
          ),
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
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              r'https://images.pexels.com/photos/13728847/pexels-photo-13728847.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            ),
          ),
          addHorizontalSpace(12.0),
          Expanded(
            child: StreamBuilder<app.User>(
                stream: ref.watch(authControllerProvider).getReceiverUserData(
                      receiverUserData['receiverUserId'] as String,
                    ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.name,
                          style: GoogleFonts.poppins(
                            color: AppColors.lightBlack,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          snapshot.data!.isOnline ? 'online' : 'offline',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Loader();
                  }
                }),
          ),
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
}
