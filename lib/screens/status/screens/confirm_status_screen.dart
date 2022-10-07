import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmStatusScreen extends ConsumerWidget {
  ConfirmStatusScreen({Key? key}) : super(key: key);

  File? _imageFile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _imageFile = ModalRoute.of(context)?.settings.arguments as File;

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
              _imageFile!,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
