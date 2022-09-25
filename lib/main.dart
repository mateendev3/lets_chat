import 'package:flutter/material.dart';
import 'router.dart';
import 'utils/colors_constants.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LetsChat',
      theme: ThemeData.light().copyWith(
        backgroundColor: AppColors.appBarColor,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
