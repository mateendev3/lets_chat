import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/constants/colors_constants.dart';

class SelectContactScreen extends ConsumerWidget {
  const SelectContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const Center(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: AppColors.onPrimary,
          ),
      title: Text(
        'Select Contact',
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              color: AppColors.onPrimary,
              fontSize: 18.0,
            ),
      ),
    );
  }
}
