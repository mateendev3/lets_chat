import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/user_data_repository.dart';
import '../../../models/user.dart' as app;

/// provider to provide UserDataController instance
final userDataControllerProvider = Provider<UserDataController>((ref) {
  final userDataRepository = ref.watch(userDataRepositoryProvider);
  return UserDataController(userDataRepository);
});

/// future provider to provide User? instance
final userDataAuthProvider = FutureProvider<app.User?>(
  (ref) {
    final userDataController = ref.watch(userDataControllerProvider);
    return userDataController.getCurrentUserData();
  },
);

class UserDataController {
  UserDataController(UserDataRepository userDataRepository)
      : _userDataRepository = userDataRepository;

  final UserDataRepository _userDataRepository;

  /// Invoke method to get current user data
  Future<app.User?> getCurrentUserData() async {
    return await _userDataRepository.getCurrentUserData();
  }

  /// invoke to save user data to Firebase.
  Future<void> saveUserDataToFirebase(
    BuildContext context,
    bool mounted, {
    required String userName,
    File? imageFile,
  }) async =>
      await _userDataRepository.saveUserDataToFirebase(
        context,
        mounted,
        userName: userName,
        imageFile: imageFile,
      );

  Stream<app.User> getReceiverUserData(String receiverUserId) {
    return _userDataRepository.getReceiverUserData(receiverUserId);
  }
}
