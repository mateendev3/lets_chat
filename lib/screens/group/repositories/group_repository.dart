import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../models/group.dart';
import '../../../models/user.dart' as app;
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/repositories/firebase_storage_repository.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/string_constants.dart';

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  return GroupRepository(FirebaseFirestore.instance, ref);
});

class GroupRepository {
  GroupRepository(FirebaseFirestore firestore, ProviderRef ref)
      : _firestore = firestore,
        _ref = ref;
  final FirebaseFirestore _firestore;
  final ProviderRef _ref;

  Future<void> createGroup(
    bool mounted,
    BuildContext context, {
    required String currentUserId,
    required String groupName,
    required File? groupProfilePic,
    required List<Contact> selectedContacts,
  }) async {
    try {
      List<String> uIds = [];
      String groupId = const Uuid().v1();

      // getting list of users from firestore
      final querySnapshot =
          await _firestore.collection(StringsConsts.usersCollection).get();
      // loop to got (doc) snapshots from querySnapshots
      for (var snapshot in querySnapshot.docs) {
        app.User user = app.User.fromMap(snapshot.data());

        // loop to compare selectedContacts number with firebase users
        // to check if the selected users exists in our app
        for (var contact in selectedContacts) {
          String number;
          try {
            number = contact.phones[0].number.replaceAll(' ', '');
          } catch (e) {
            number = '+12345667';
          }

          if (user.phoneNumber == number) {
            uIds.add(user.uid);
          }
        }
      }

      // uploading our groupProfilePic to firebase storage and get url
      if (!mounted) return;
      String groupProfilePicUrl = await _ref
          .read(firebaseStorageRepositoryProvider)
          .storeFileToFirebaseStorage(
            context,
            file: groupProfilePic!,
            path: 'groups',
            fileName: groupId,
          );

      // creating group instance
      final Group group = Group(
        groupName: groupName,
        groupId: groupId,
        groupProfilePic: groupProfilePicUrl,
        lastMessage: '',
        lastMessageUserSenderId: currentUserId,
        time: DateTime.now(),
        selectedMembersUIds: [currentUserId, ...uIds],
      );

      await _firestore
          .collection(StringsConsts.groupsCollection)
          .doc(groupId)
          .set(group.toMap());
    } catch (e) {
      showSnackBar(context, content: e.toString());
    }
  }
}
