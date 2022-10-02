import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/select_receiver_contact_repository.dart';

final selectReceiverContactsControllerProvider =
    FutureProvider.family<List<Contact>, BuildContext>(
  (ref, context) {
    final selectReceiverContactsRepository =
        ref.watch(selectReceiverContactsRepositoryProvider);
    return selectReceiverContactsRepository.getReceiverContacts(context);
  },
);

final selectReceiverContactControllerProvider = Provider(
  (ref) {
    final selectReceiverContactsRepository =
        ref.watch(selectReceiverContactsRepositoryProvider);
    return SelectReceiverContactController(
        repository: selectReceiverContactsRepository);
  },
);

class SelectReceiverContactController {
  SelectReceiverContactController({
    required SelectReceiverContactsRepository repository,
  }) : _selectContactsRepository = repository;

  final SelectReceiverContactsRepository _selectContactsRepository;

  /// invoke to select specific user if it exists
  Future<void> selectReceiverContact(
    bool mounted,
    BuildContext context, {
    required Contact contact,
  }) async {
    String number = contact.phones[0].number.replaceAll(' ', '');
    return await _selectContactsRepository.selectReceiverContact(
      mounted,
      context,
      number: number,
    );
  }
}
