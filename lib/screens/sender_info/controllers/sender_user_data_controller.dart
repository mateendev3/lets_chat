import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/sender_user_data_repository.dart';
import '../../../models/user.dart' as app;

/// provider to provide UserDataController instance
final senderUserDataControllerProvider =
    Provider<SenderUserDataController>((ref) {
  final senderUserDataRepository = ref.watch(senderUserDataRepositoryProvider);
  return SenderUserDataController(senderUserDataRepository);
});

/// future provider to provide User? instance
final senderUserDataAuthProvider = FutureProvider<app.User?>(
  (ref) {
    final senderUserDataController =
        ref.watch(senderUserDataControllerProvider);
    return senderUserDataController.getSenderUserData();
  },
);

class SenderUserDataController {
  SenderUserDataController(SenderUserDataRepository senderUserDataRepository)
      : _senderUserDataRepository = senderUserDataRepository;

  final SenderUserDataRepository _senderUserDataRepository;

  /// Invoke method to get current user data
  Future<app.User?> getSenderUserData() async {
    return await _senderUserDataRepository.getSenderUserData();
  }

  /// invoke to save user data to Firebase.
  Future<void> saveSenderUserDataToFirebase(
    BuildContext context,
    bool mounted, {
    required String userName,
    File? imageFile,
  }) async =>
      await _senderUserDataRepository.saveSenderUserDataToFirebase(
        context,
        mounted,
        userName: userName,
        imageFile: imageFile,
      );

  Future<void> setSenderUserState(bool isOnline) async {
    _senderUserDataRepository.setSenderUserState(isOnline);
  }
}
