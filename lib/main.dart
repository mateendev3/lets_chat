import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'router.dart';
import 'utils/constants/routes_constants.dart';
import 'utils/constants/string_constants.dart';
import 'utils/constants/theme_constants.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringsConsts.appName,
      theme: appTheme,
      initialRoute: AppRoutes.landingScreen,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
