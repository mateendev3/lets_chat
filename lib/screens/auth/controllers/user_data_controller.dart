import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/user_data_repository.dart';

final userDataControllerProvider = Provider<UserDataController>((ref) {
  final userDataRepository = ref.watch(userDataRepositoryProvider);
  return UserDataController(userDataRepository);
});

class UserDataController {
  UserDataController(UserDataRepository userDataRepository)
      : _userDataRepository = userDataRepository;

  final UserDataRepository _userDataRepository;

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
}
