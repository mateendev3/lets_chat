import 'package:flutter/material.dart';
import '../../../utils/constants/assets_constants.dart';

class NoChat extends StatelessWidget {
  const NoChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.9,
        child: Opacity(
          opacity: 0.8,
          child: Image.asset(
            ImagesConsts.icNoChat,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
