import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/routes_constants.dart';

/// provider to get AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(FirebaseAuth.instance),
);

class AuthRepository {
  AuthRepository(FirebaseAuth auth) : _auth = auth;

  final FirebaseAuth _auth;

  /// Invoke to signIn user with phone number.
  Future<void> signInWithPhone(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
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

  /// Invoke to verify otp.
  Future<void> verifyOTP(
    BuildContext context,
    bool mounted, {
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      log('000000000000000000111111111111111100000000000000');
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      log('000000000000000000111111111111111100000000000000');

      if (userCredential.user != null) {
        log('000000000000000000111111111111111100000000000000');

        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.userInformationScreen,
          (route) => false,
        );
      } else {
        throw Exception('Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, content: e.message!);
    }
  }
}
