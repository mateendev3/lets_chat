import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/select_receiver_contacts_controller.dart';

final contactsListStateProvider = StateNotifierProvider.family<
    ContactsListStateNotifier, ContactsListState, BuildContext>(
  (ref, context) {
    return ref.watch(selectReceiverContactsControllerProvider(context)).when(
      data: (data) {
        return ContactsListStateNotifier(
          contactList: data,
          state: GetAllReceiverContactsListState(data),
        );
      },
      error: (error, stackTrace) {
        return ContactsListStateNotifier(
          contactList: [],
          state: ErrorReceiverContactsListState(error.toString()),
        );
      },
      loading: () {
        return ContactsListStateNotifier(
          contactList: [],
          state: const LoadingReceiverContactsListState(),
        );
      },
    );
  },
);

/// Base class for list states
@immutable
abstract class ContactsListState extends Equatable {
  const ContactsListState();
}

class GetAllReceiverContactsListState extends ContactsListState {
  const GetAllReceiverContactsListState(this.contactList);

  final List<Contact> contactList;

  @override
  List<Object?> get props => [contactList];

  @override
  bool? get stringify => true;
}

class SearchedReceiverContactsListState extends ContactsListState {
  const SearchedReceiverContactsListState(this.searchedQueryList);

  final List<Contact> searchedQueryList;

  @override
  List<Object?> get props => [searchedQueryList];

  @override
  bool? get stringify => true;
}

class ErrorReceiverContactsListState extends ContactsListState {
  const ErrorReceiverContactsListState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => true;
}

class LoadingReceiverContactsListState extends ContactsListState {
  const LoadingReceiverContactsListState();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

/// Contacts List State Notifier for notifying listeners.
class ContactsListStateNotifier extends StateNotifier<ContactsListState> {
  ContactsListStateNotifier({
    required this.contactList,
    required ContactsListState state,
  }) : super(state);

  final List<Contact> contactList;

  void getSearchedContactsList(String query) async {
    List<Contact> filteredList = contactList
        .where((contact) =>
            contact.displayName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    state = SearchedReceiverContactsListState(filteredList);
  }
}
