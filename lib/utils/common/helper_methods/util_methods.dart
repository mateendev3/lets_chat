import 'dart:io';
import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/string_constants.dart';
import '../enums/message_type.dart';
import '../widgets/helper_widgets.dart';

/// Invoke to pick image from gallery.
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

/// Invoke to pick video from gallery.
Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? videoFile;

  try {
    XFile? xFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 1),
    );

    if (xFile != null) {
      videoFile = File(xFile.path);
    }
  } catch (e) {
    showSnackBar(context, content: e.toString());
  }

  return videoFile;
}

/// Invoke to pick GIF.
Future<GiphyGif?> pickGIG(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await GiphyPicker.pickGif(
      title: const Text('Pick GIF'),
      context: context,
      apiKey: StringsConsts.giphyApiKey,
    );
  } catch (e) {
    showSnackBar(context, content: e.toString());
  }
  return gif;
}

/// Invoke to get file type which you are going to send.
String getFileType(MessageType messageType) {
  switch (messageType) {
    case MessageType.image:
      return '📷 Photo';
    case MessageType.gif:
      return 'GIF';
    case MessageType.audio:
      return '🎵 Audio';
    case MessageType.video:
      return '📸 Video';
    default:
      return 'GIF';
  }
}
