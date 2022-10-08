import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageRepositoryProvider = Provider(
  (ref) => FirebaseStorageRepository(FirebaseStorage.instance),
);

class FirebaseStorageRepository {
  FirebaseStorageRepository(FirebaseStorage storage)
      : _firebaseStorage = storage;

  final FirebaseStorage _firebaseStorage;

  /// To upload file to firebase storage
  Future<String> storeFileToFirebaseStorage(
    BuildContext context, {
    required File file,
    required String path,
    required String fileName,
  }) async {
    try {
      UploadTask imageUploadTask =
          _firebaseStorage.ref().child(path).child(fileName).putFile(file);
      TaskSnapshot snapshot = await imageUploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw 'Image not found';
    }
  }
}
