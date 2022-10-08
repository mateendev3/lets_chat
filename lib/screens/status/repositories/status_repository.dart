import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/status.dart';
import '../../../models/user.dart' as app;
import 'package:uuid/uuid.dart';
import '../../../utils/common/repositories/firebase_storage_repository.dart';
import '../../../utils/constants/string_constants.dart';

final statusRepositoryProvider = Provider(
  (ref) => StatusRepository(
    firestore: FirebaseFirestore.instance,
    ref: ref,
  ),
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
    required String currentUsername,
    required String currentUserProfilePic,
    required String currentUserPhoneNumber,
    required String currentUserId,
    required File currentUserStatusImage,
  }) async {
    try {
      String statusId = const Uuid().v1();
      log('repo called');

      // saving statusImage to firebase storage.
      String? statusImageUrl = await _ref
          .read(firebaseStorageRepositoryProvider)
          .storeFileToFirebaseStorage(
            context,
            file: currentUserStatusImage,
            path: 'status',
            fileName: '$currentUserId/$statusId',
          );

      log('image aa gyi: $statusImageUrl');

      // getting list of contacts from device
      List<Contact> contactsList = [];
      if (await FlutterContacts.requestPermission()) {
        contactsList = await FlutterContacts.getContacts(
          withPhoto: true,
          withProperties: true,
        );
      }
      log('contact list aa gyi, length : ${contactsList.length}');

      // getting list of users who can see user status
      List<String> whoCanSeeList = [];
      for (var contact in contactsList) {
        log('loop');
        String phoneNumber;
        try {
          phoneNumber = contact.phones[0].number.replaceAll(' ', '');
        } catch (e) {
          phoneNumber = '+92345';
        }
        final querySnapshot = await _firestore
            .collection(StringsConsts.usersCollection)
            .where(
              'phoneNumber',
              isEqualTo: phoneNumber,
            )
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          app.User user = app.User.fromMap(querySnapshot.docs[0].data());
          log('log aa gye to status dekh skty $user');
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

        statusImageUrls.add(statusImageUrl);
        log('1');

        log(statusImageUrls.toString());

        // updating already added status
        await _firestore
            .collection(StringsConsts.statusCollection)
            .doc(statusID)
            .update({'photoUrls': statusImageUrls});
        return;
      }

      statusImageUrls = [statusImageUrl];
      log('2');
      log(statusImageUrls.toString());

      Status status = Status(
        uid: currentUserId,
        username: currentUsername,
        phoneNumber: currentUserPhoneNumber,
        profilePic: currentUserProfilePic,
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
    } catch (e) {
      log(e.toString());
    }
  }
}
