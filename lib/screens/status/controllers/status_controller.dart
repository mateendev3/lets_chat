import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user.dart' as app;
import '../../../utils/common/providers/current_user_provider.dart';
import '../repositories/status_repository.dart';

final statusControllerProvider = Provider<StatusController>(
  (ref) {
    return StatusController(
      statusRepository: ref.read(statusRepositoryProvider),
      ref: ref,
    );
  },
);

class StatusController {
  final StatusRepository _statusRepository;
  final ProviderRef _ref;
  StatusController({
    required StatusRepository statusRepository,
    required ProviderRef ref,
  })  : _statusRepository = statusRepository,
        _ref = ref;

  Future<void> uploadStatus(
    BuildContext context, {
    required File currentUserStatusImage,
  }) async {
    if (currentUserProvider != null) {
      app.User user = _ref.read(currentUserProvider!);
      log('controller called');

      _statusRepository.uploadStatus(
        context,
        currentUsername: user.name,
        currentUserId: user.uid,
        currentUserProfilePic: user.profilePic ?? '',
        currentUserPhoneNumber: user.phoneNumber,
        currentUserStatusImage: currentUserStatusImage,
      );
    }
  }
}
