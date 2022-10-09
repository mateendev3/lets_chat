import 'package:flutter/material.dart';
import '../../constants/colors_constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.black,
        ),
      ),
    );
  }
}
