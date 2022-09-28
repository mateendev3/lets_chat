import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/helper_widgets.dart';

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? imageFile;

  try {
    XFile? xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (xFile != null) {
      imageFile = File(xFile.path);
    }
  } catch (e) {
    showSnackBar(context, content: e.toString());
  }

  return imageFile;
}
