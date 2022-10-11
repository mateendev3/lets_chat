import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/status.dart';
import '../../../models/user.dart' as app;
import 'package:uuid/uuid.dart';
import '../../../utils/common/repositories/firebase_storage_repository.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
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

      // saving statusImage to firebase storage.
      String? statusImageUrl = await _ref
          .read(firebaseStorageRepositoryProvider)
          .storeFileToFirebaseStorage(
            context,
            file: currentUserStatusImage,
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

      // getting list of available users from firebase.
      List<app.User> firebaseUsers =
          (await _firestore.collection(StringsConsts.usersCollection).get())
              .docs
              .map((doc) => app.User.fromMap(doc.data()))
              .toList();

      // getting list of users who can see user status
      List<String> whoCanSeeList = [];
      for (var contact in contactsList) {
        String phoneNumber;
        try {
          phoneNumber = contact.phones[0].number.replaceAll(' ', '');
        } catch (e) {
          phoneNumber = '+1234567890';
        }

        // getting firebase and contactList common users with phoneNumber
        List<app.User> usersWithAvailableNumber = firebaseUsers
            .where((user) => user.phoneNumber == phoneNumber)
            .toList();

        if (usersWithAvailableNumber.isNotEmpty) {
          whoCanSeeList.add(usersWithAvailableNumber[0].uid);
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

        // updating already added status
        await _firestore
            .collection(StringsConsts.statusCollection)
            .doc(statusID)
            .update({'photoUrls': statusImageUrls});

        return;
      }

      // saving status to firebase if it is the first time.
      statusImageUrls = [statusImageUrl];
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
      showSnackBar(context, content: e.toString());
    }
  }

  /// invoke to get statuses
  Future<List<Status>> getStatuses(
    BuildContext context,
    app.User currentUser,
  ) async {
    List<Status> statusList = [];
    try {
      // getting list of contacts from device
      List<Contact> contactsList = [];
      if (await FlutterContacts.requestPermission()) {
        contactsList = await FlutterContacts.getContacts(
          withPhoto: true,
          withProperties: true,
        );
      }

      // getting list of available statuses from firebase.
      List<Status> firebaseStatuses =
          (await _firestore.collection(StringsConsts.statusCollection).get())
              .docs
              .map((doc) => Status.fromMap(doc.data()))
              .toList();

      // getting list of status which will be only available to users
      // who are in the contact list of current user and vice versa.
      for (var contact in contactsList) {
        String phoneNumber;
        try {
          phoneNumber = contact.phones[0].number.replaceAll(' ', '');
        } catch (e) {
          phoneNumber = '+1234567890';
        }
        List<Status> statuses = firebaseStatuses
            .where((status) => status.phoneNumber == phoneNumber)
            .toList();
        //* filter by time (last 24 hour statuses)
        // .where((status) =>
        //     status.time.microsecondsSinceEpoch >
        //     DateTime.now()
        //         .subtract(const Duration(hours: 24))
        //         .microsecondsSinceEpoch)
        // .toList();

        for (var status in statuses) {
          if (status.whoCanSee.contains(currentUser.uid)) {
            statusList.add(status);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) print(e);
      showSnackBar(context, content: e.toString());
    }
    return statusList;
  }
}
