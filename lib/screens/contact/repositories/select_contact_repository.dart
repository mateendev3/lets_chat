import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/widgets/helper_widgets.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactsRepository(),
);

class SelectContactsRepository {
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
}
