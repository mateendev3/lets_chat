import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusScreen extends ConsumerWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Status'),
    );
  }
}
