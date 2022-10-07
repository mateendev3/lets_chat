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
    required File statusImage,
  }) async {
    if (currentUserProvider != null) {
      app.User user = _ref.read(currentUserProvider!);
      _statusRepository.uploadStatus(
        context,
        username: user.name,
        profilePic: user.profilePic ?? '',
        phoneNumber: user.phoneNumber,
        statusImage: statusImage,
      );
    }
  }
}
