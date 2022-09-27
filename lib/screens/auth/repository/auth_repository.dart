import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../utils/common/helper_widgets.dart';
import '../../../utils/constants/routes_constants.dart';

class AuthRepository {
  AuthRepository({
    required FirebaseAuth auth,
  }) : _auth = auth;

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
