import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/widgets/loader.dart';
import '../../../utils/constants/colors_constants.dart';
import '../widgets/contacts_list.dart';
import '../state/contacts_list_state_notifier.dart';

class SelectReceiverContactScreen extends ConsumerStatefulWidget {
  const SelectReceiverContactScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectReceiverContactScreenState();
}

class _SelectReceiverContactScreenState
    extends ConsumerState<SelectReceiverContactScreen> {
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
              ContactsListState state =
                  ref.watch(contactsListStateProvider(context));
              if (state is LoadingReceiverContactsListState) {
                return const Loader();
              } else if (state is GetAllReceiverContactsListState) {
                return ContactsList(contactsList: state.contactList);
              } else if (state is SearchedReceiverContactsListState) {
                return ContactsList(contactsList: state.searchedQueryList);
              } else if (state is ErrorReceiverContactsListState) {
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
        .read(contactsListStateProvider(context).notifier)
        .getSearchedContactsList(value);
  }
}
