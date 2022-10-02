import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/constants/colors_constants.dart';
import '../utils/constants/routes_constants.dart';
import '../utils/constants/string_constants.dart';
import '../utils/widgets/chats_list.dart';
import 'auth/controllers/user_data_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        ref.watch(userDataControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        ref.watch(userDataControllerProvider).setUserState(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: const ChatsList(),
        floatingActionButton: _buildFAB(context),
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
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.landingScreen,
              (route) => false,
            );
          },
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
  FloatingActionButton _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.selectContactScreen);
      },
      child: const Icon(
        Icons.chat_rounded,
      ),
    );
  }
}
