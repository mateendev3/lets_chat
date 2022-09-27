import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../utils/constants/colors_constants.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late final String? verificationId;

  @override
  void initState() {
    super.initState();
    verificationId = ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    log(verificationId ?? '');
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: AppColors.onPrimary,
          ),
      title: Text(
        'Enter OTP',
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              color: AppColors.onPrimary,
              fontSize: 18.0,
            ),
      ),
    );
  }
}
