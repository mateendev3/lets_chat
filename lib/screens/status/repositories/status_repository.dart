import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/status.dart';
import '../../../models/user.dart' as app;
import 'package:uuid/uuid.dart';
import '../../../utils/common/providers/current_user_provider.dart';
import '../../../utils/common/repositories/firebase_storage_repository.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/string_constants.dart';

final statusRepositoryProvider = Provider(
  (ref) => StatusRepository(firestore: FirebaseFirestore.instance, ref: ref),
);

class StatusRepository {
  StatusRepository({
    required FirebaseFirestore firestore,
    required ProviderRef ref,
  })  : _firestore = firestore,
        _ref = ref;

  final FirebaseFirestore _firestore;
  final ProviderRef _ref;

  Future<void> uploadStatus(
    BuildContext context, {
    required String username,
    required String profilePic,
    required String phoneNumber,
    required File statusImage,
  }) async {
    try {
      String statusId = const Uuid().v1();
      final String currentUserId = _ref.read(currentUserProvider!).uid;

      // saving statusImage to firebase
      String? statusImageUrl = await _ref
          .read(firebaseStorageRepositoryProvider)
          .storeFileToFirebaseStorage(
            context,
            file: statusImage,
            path: 'status',
            fileName: '$currentUserId/$statusId',
          );

      // getting list of contacts from device
      List<Contact> contactsList = [];
      if (await FlutterContacts.requestPermission()) {
        contactsList = await FlutterContacts.getContacts(
          withPhoto: true,
          withProperties: true,
        );
      }

      // getting list of users who can see our status
      List<String> whoCanSeeList = [];
      for (var contact in contactsList) {
        final querySnapshot = await _firestore
            .collection(StringsConsts.usersCollection)
            .where(
              'phoneNumber',
              isEqualTo: contact.phones[0].number.replaceAll(' ', ''),
            )
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          app.User user = app.User.fromMap(querySnapshot.docs[0].data());
          whoCanSeeList.add(user.uid);
        }
      }

      // getting status images, if the user already added
      List<String> statusImageUrls = [];
      final statusQuerySnapshot = await _firestore
          .collection(StringsConsts.statusCollection)
          .where('uid', isEqualTo: currentUserId)
          .get();

      if (statusQuerySnapshot.docs.isNotEmpty) {
        String statusID = statusQuerySnapshot.docs[0].id;
        Status status = Status.fromMap(statusQuerySnapshot.docs[0].data());
        statusImageUrls = status.photoUrls;

        if (statusImageUrl != null) {
          statusImageUrls.add(statusImageUrl);
        }

        // updating already added status
        await _firestore
            .collection(StringsConsts.statusCollection)
            .doc(statusID)
            .update({'photoUrls': statusImageUrls});
        return;
      }

      if (statusImageUrl != null) {
        statusImageUrls = [statusImageUrl];
        Status status = Status(
          uid: currentUserId,
          username: username,
          phoneNumber: phoneNumber,
          profilePic: profilePic,
          statusId: statusId,
          photoUrls: statusImageUrls,
          whoCanSee: whoCanSeeList,
          time: DateTime.now(),
        );

        // adding status
        await _firestore
            .collection(StringsConsts.statusCollection)
            .doc(statusId)
            .set(status.toMap());
      }
    } catch (e) {
      showSnackBar(context, content: e.toString());
    }
  }
}
