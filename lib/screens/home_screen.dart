import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants/colors_constants.dart';
import '../utils/constants/string_constants.dart';
import '../utils/widgets/chats_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: const ChatsList(),
        floatingActionButton: _buildFAB(),
      ),
    );
  }

  /// AppBar of the home screen
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
      ),
      title: Text(
        StringsConsts.appName,
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: AppColors.appBarActionIcon,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.appBarActionIcon,
          ),
        ),
      ],
      bottom: TabBar(
        indicatorColor: AppColors.white,
        indicatorWeight: 4.0,
        labelColor: AppColors.sTabLabel,
        unselectedLabelColor: AppColors.uTabLabel,
        labelStyle: Theme.of(context).textTheme.headlineSmall,
        tabs: const [
          Tab(text: 'CHATS'),
          Tab(text: 'STATUS'),
          Tab(text: 'CALLS'),
        ],
      ),
    );
  }

  /// FAB of the home screen
  FloatingActionButton _buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(
        Icons.chat_rounded,
      ),
    );
  }
}
