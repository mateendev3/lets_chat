import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/select_contacts_controller.dart';

final contactsListStateProvider = StateNotifierProvider.family<
    ContactsListStateNotifier, ContactsListState, BuildContext>(
  (ref, context) {
    return ref.watch(selectContactsControllerProvider(context)).when(
      data: (data) {
        return ContactsListStateNotifier(
          contactList: data,
          state: GetAllContactsListState(data),
        );
      },
      error: (error, stackTrace) {
        return ContactsListStateNotifier(
          contactList: [],
          state: ErrorContactsListState(error.toString()),
        );
      },
      loading: () {
        return ContactsListStateNotifier(
          contactList: [],
          state: const LoadingContactsListState(),
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

class GetAllContactsListState extends ContactsListState {
  const GetAllContactsListState(this.contactList);

  final List<Contact> contactList;

  @override
  List<Object?> get props => [contactList];

  @override
  bool? get stringify => true;
}

class SearchedContactsListState extends ContactsListState {
  const SearchedContactsListState(this.searchedQueryList);

  final List<Contact> searchedQueryList;

  @override
  List<Object?> get props => [searchedQueryList];

  @override
  bool? get stringify => true;
}

class ErrorContactsListState extends ContactsListState {
  const ErrorContactsListState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => true;
}

class LoadingContactsListState extends ContactsListState {
  const LoadingContactsListState();

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
    state = SearchedContactsListState(filteredList);
  }
}
