import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/auth_repository.dart';

final authControllerProvider = Provider<AuthController>(
  (ref) {
    final authRepository = ref.watch<AuthRepository>(authRepositoryProvider);
    return AuthController(authRepository);
  },
);

class AuthController {
  AuthController(AuthRepository authRepository)
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// Invoke to signIn user with phone number.
  void signInWithPhone(
    BuildContext context, {
    required String phoneNumber,
  }) =>
      _authRepository.signInWithPhone(
        context,
        phoneNumber: phoneNumber,
      );
}
