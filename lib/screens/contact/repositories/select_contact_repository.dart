import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_chat/models/user.dart' as app;
import 'package:lets_chat/utils/constants/routes_constants.dart';
import 'package:lets_chat/utils/constants/string_constants.dart';
import '../../../utils/common/widgets/helper_widgets.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactsRepository(FirebaseFirestore.instance),
);

class SelectContactsRepository {
  SelectContactsRepository(FirebaseFirestore firestore)
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// invoke to Get all contacts (fully fetched)
  Future<List<Contact>> getContacts(BuildContext context) async {
    List<Contact> contactsList = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contactsList = await FlutterContacts.getContacts(
          withPhoto: true,
          withProperties: true,
        );
      }
    } catch (e) {
      showSnackBar(context, content: e.toString());
    }

    return contactsList;
  }

  /// invoke to select specific user if it exists
  Future<void> selectContact(
    bool mounted,
    BuildContext context, {
    required String number,
  }) async {
    bool isFound = false;
    final userCollection =
        await _firestore.collection(StringsConsts.userCollection).get();

    for (var document in userCollection.docs) {
      app.User user = app.User.fromMap(document.data());

      if (number == user.phoneNumber) {
        isFound = true;

        if (!mounted) return;
        Navigator.pushNamed(
          context,
          AppRoutes.chatScreen,
          arguments: <String, Object>{
            'name': user.name,
            'uid': user.uid,
          },
        );
      }
    }

    if (!isFound) {
      if (!mounted) return;
      showSnackBar(context, content: "User doesn't exist in this app");
    }
  }
}
