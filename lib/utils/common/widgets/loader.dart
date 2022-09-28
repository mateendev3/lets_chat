import 'package:flutter/material.dart';
import 'package:lets_chat/utils/constants/colors_constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.black,
      ),
    );
  }
}
