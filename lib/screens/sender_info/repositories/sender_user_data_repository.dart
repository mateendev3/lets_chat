import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user.dart' as app;
import '../../../utils/common/repositories/firebase_storage_repository.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/routes_constants.dart';
import '../../../utils/constants/string_constants.dart';

final senderUserDataRepositoryProvider = Provider<SenderUserDataRepository>(
  (ref) => SenderUserDataRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class SenderUserDataRepository {
  SenderUserDataRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required ProviderRef ref,
  })  : _firestore = firestore,
        _ref = ref,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final ProviderRef _ref;

  /// Invoke method to get current user data
  Future<app.User?> getSenderUserData() async {
    final userData = await _firestore
        .collection(StringsConsts.usersCollection)
        .doc(_auth.currentUser?.uid)
        .get();

    app.User? user;
    if (userData.data() != null) {
      user = app.User.fromMap(userData.data()!);
    }

    return user;
  }

  /// invoke to save user data to Firebase.
  Future<void> saveSenderUserDataToFirebase(
    BuildContext context,
    bool mounted, {
    required String userName,
    File? imageFile,
  }) async {
    try {
      String uId = _auth.currentUser!.uid;
      String? photoUrl;

      if (imageFile != null) {
        // uploading image file to cloud storage and get its url.
        photoUrl = await _ref
            .read(firebaseStorageRepositoryProvider)
            .storeFileToFirebaseStorage(
              context,
              file: imageFile,
              path: 'profilePic',
              fileName: uId,
            );
      }

      // creating user instance.
      app.User user = app.User(
        name: userName,
        uid: uId,
        isOnline: true,
        profilePic: photoUrl,
        groupId: [],
        phoneNumber: _auth.currentUser!.phoneNumber!,
      );

      // saving user to firestore.
      await _firestore
          .collection(StringsConsts.usersCollection)
          .doc(uId)
          .set(user.toMap());

      if (!mounted) return;
      // navigating to home screen if everything works well
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.homeScreen,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, content: e.toString());
    }
  }

  Future<void> setSenderUserState(bool isOnline) async {
    await _firestore
        .collection(StringsConsts.usersCollection)
        .doc(_auth.currentUser!.uid)
        .update({
      'isOnline': isOnline,
    });
  }
}
