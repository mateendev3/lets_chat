// ignore_for_file: public_member_api_docs, sort_constructors_first
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

final selectContactControllerProvider = Provider(
  (ref) {
    final selectContactsRepository =
        ref.watch(selectContactsRepositoryProvider);
    return SelectContactController(repository: selectContactsRepository);
  },
);

class SelectContactController {
  SelectContactController({
    required SelectContactsRepository repository,
  }) : _selectContactsRepository = repository;

  final SelectContactsRepository _selectContactsRepository;

  /// invoke to select specific user if it exists
  Future<void> selectContact(
    bool mounted,
    BuildContext context, {
    required Contact contact,
  }) async {
    String number = contact.phones[0].number.replaceAll(' ', '');
    return await _selectContactsRepository.selectContact(
      mounted,
      context,
      number: number,
    );
  }
}
