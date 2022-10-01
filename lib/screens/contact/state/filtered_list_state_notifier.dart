import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_chat/screens/contact/controllers/select_contacts_controller.dart';

final filteredListStateProvider = StateNotifierProvider.family<
    FilteredListStateNotifier, FilteredListState, BuildContext>(
  (ref, context) {
    return ref.watch(selectContactsControllerProvider(context)).when(
      data: (data) {
        return FilteredListStateNotifier(
          contactList: data,
          state: EmptyFilteredListState(data),
        );
      },
      error: (error, stackTrace) {
        return FilteredListStateNotifier(
          contactList: [],
          state: ErrorFilteredListState(error.toString()),
        );
      },
      loading: () {
        return FilteredListStateNotifier(
          contactList: [],
          state: const LoadingFilteredListState(),
        );
      },
    );
  },
);

@immutable
abstract class FilteredListState extends Equatable {
  const FilteredListState();
}

class EmptyFilteredListState extends FilteredListState {
  const EmptyFilteredListState(this.contactList);

  final List<Contact> contactList;

  @override
  List<Object?> get props => [contactList];

  @override
  bool? get stringify => true;
}

class SearchedFilteredListState extends FilteredListState {
  const SearchedFilteredListState(this.searchedQueryList);

  final List<Contact> searchedQueryList;

  @override
  List<Object?> get props => [searchedQueryList];

  @override
  bool? get stringify => true;
}

class ErrorFilteredListState extends FilteredListState {
  const ErrorFilteredListState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => true;
}

class LoadingFilteredListState extends FilteredListState {
  const LoadingFilteredListState();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class FilteredListStateNotifier extends StateNotifier<FilteredListState> {
  FilteredListStateNotifier({
    required this.contactList,
    required FilteredListState state,
  }) : super(state);

  final List<Contact> contactList;

  void getSearchQueryList(String query) async {
    log(query);
    // if (query.isEmpty) {
    //   final list = contactList;
    //   state = EmptyFilteredListState(list);
    //   debugPrint('empty state changed');
    // } else {
    List<Contact> filteredList = contactList
        .where(
          (contact) =>
              contact.displayName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    debugPrint(filteredList.length.toString());
    state = SearchedFilteredListState(filteredList);
    // }
  }
}
