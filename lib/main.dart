import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'router/router.dart';
import 'screens/sender_info/controllers/sender_user_data_controller.dart';
import 'utils/common/screens/error_screen.dart';
import 'screens/home/screens/home_screen.dart';
import 'screens/landing/screens/landing_screen.dart';
import 'utils/common/screens/loading_screen.dart';
import 'utils/common/providers/current_user_provider.dart';
import 'utils/constants/string_constants.dart';
import 'utils/constants/theme_constants.dart';
import './models/user.dart' as app;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringsConsts.appName,
      theme: appTheme,
      home: _getHomeWidget(ref),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }

  Widget _getHomeWidget(WidgetRef ref) {
    return ref.watch(senderUserDataAuthProvider).when<Widget>(
          data: (app.User? user) {
            if (user == null) return const LandingScreen();
            currentUserProvider ??= Provider((ref) => user);
            return const HomeScreen();
          },
          error: (error, stackTrace) => ErrorScreen(
            error: error.toString(),
          ),
          loading: () => const LoadingScreen(),
        );
  }
}
