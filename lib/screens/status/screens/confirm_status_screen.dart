import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/status_controller.dart';

class ConfirmStatusScreen extends ConsumerWidget {
  const ConfirmStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final File imageFile = ModalRoute.of(context)?.settings.arguments as File;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Want to add to status?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.file(
              imageFile,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
        onPressed: () => addStatus(context, ref, imageFile),
      ),
    );
  }

  void addStatus(BuildContext context, WidgetRef ref, File imageFile) {
    ref.read(statusControllerProvider).uploadStatus(
          context,
          currentUserStatusImage: imageFile,
        );
    Navigator.pop(context);
  }
}
