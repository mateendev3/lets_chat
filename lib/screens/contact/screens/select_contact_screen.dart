import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/widgets/loader.dart';
import '../../../utils/constants/colors_constants.dart';
import '../../../utils/widgets/contacts_list.dart';
import '../state/filtered_list_state_notifier.dart';

class SelectContactScreen extends ConsumerStatefulWidget {
  const SelectContactScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectContactScreenState();
}

class _SelectContactScreenState extends ConsumerState<SelectContactScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('build');
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: AppColors.onPrimary,
          ),
      title: Text(
        'Select Contact',
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              color: AppColors.onPrimary,
              fontSize: 18.0,
            ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSearchNoteTF(),
        Expanded(
          // child: ref.watch(selectContactsControllerProvider(context)).when(
          //       data: (contactsList) =>
          //           ContactsList(contactsList: contactsList),
          //       error: (error, stackTrace) =>
          //           ErrorViewer(error: error.toString()),
          //       loading: () => const Loader(),
          //     ),
          child: Consumer(
            builder: (consumerContext, ref, child) {
              FilteredListState state =
                  ref.watch(filteredListStateProvider(context));
              // log('main ==> $state');

              if (state is LoadingFilteredListState) {
                log(filteredListStateProvider.toString());

                return const Loader();
              } else if (state is EmptyFilteredListState) {
                log('empty called');
                log(filteredListStateProvider.toString());
                return ContactsList(contactsList: state.contactList);
              } else if (state is SearchedFilteredListState) {
                return ContactsList(contactsList: state.searchedQueryList);
              } else if (state is ErrorFilteredListState) {
                return Text(state.errorMessage);
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchNoteTF() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: TextField(
        controller: _searchController,
        cursorColor: AppColors.black,
        onChanged: _onChangedText,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: size.width * 0.04,
            ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.chatOffWhite,
          enabled: true,
          suffixIcon: _searchController.text.isEmpty
              ? const Icon(
                  Icons.search,
                  color: AppColors.primary,
                )
              : IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColors.white,
                  ),
                ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          hintText: 'search by name',
          hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: AppColors.grey,
                fontSize: size.width * 0.04,
              ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _onChangedText(String value) {
    ref
        .read(filteredListStateProvider(context).notifier)
        .getSearchQueryList(value);
  }
}
