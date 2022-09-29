import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/select_contact_repository.dart';

final selectContactsControllerProvider =
    FutureProvider.family<List<Contact>, BuildContext>(
  (ref, context) {
    final selectContactsRepository =
        ref.watch(selectContactsRepositoryProvider);
    return selectContactsRepository.getContacts(context);
  },
);
