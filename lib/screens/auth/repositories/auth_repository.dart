import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/helper_widgets.dart';
import '../../../utils/constants/routes_constants.dart';

/// provider to get AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(FirebaseAuth.instance),
);

class AuthRepository {
  AuthRepository(FirebaseAuth auth) : _auth = auth;

  final FirebaseAuth _auth;

  /// Invoke to signIn user with phone number.
  void signInWithPhone(
    BuildContext context, {
    required String phoneNumber,
  }) {
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (_) {},
        verificationFailed: (FirebaseAuthException error) {
          throw Exception(error.message);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          Navigator.pushNamed(
            context,
            AppRoutes.otpScreen,
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, content: e.message!);
    }
  }
}
