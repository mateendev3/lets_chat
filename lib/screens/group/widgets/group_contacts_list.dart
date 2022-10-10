import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/widgets/loader.dart';
import '../../../utils/constants/colors_constants.dart';
import '../../contact/state/contacts_list_state_notifier.dart';

final selectedContactsGroupProvider = StateProvider<List<Contact>>((ref) => []);

class GroupContactsList extends ConsumerStatefulWidget {
  const GroupContactsList({
    super.key,
  });

  @override
  ConsumerState<GroupContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends ConsumerState<GroupContactsList> {
  List<int> selectedContactsIndexList = [];

  void selectContact(int index, Contact contact) {
    if (selectedContactsIndexList.contains(index)) {
      selectedContactsIndexList.remove(index);
      ref.read(selectedContactsGroupProvider.state).update(
            (state) => [...state..remove(contact)],
          );
    } else {
      selectedContactsIndexList.add(index);
      ref.read(selectedContactsGroupProvider.state).update(
            (state) => [...state, contact],
          );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (consumerContext, ref, child) {
          ContactsListState state =
              ref.watch(contactsListStateProvider(context));
          if (state is LoadingReceiverContactsListState) {
            return const Loader();
          } else if (state is GetAllReceiverContactsListState) {
            return ListView.builder(
              itemCount: state.contactList.length,
              itemBuilder: (context, index) => getListItem(
                state.contactList[index],
                index,
              ),
            );
          } else if (state is ErrorReceiverContactsListState) {
            return Text(state.errorMessage);
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }

  Widget getListItem(Contact contact, int index) {
    String name = contact.displayName;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: () => selectContact(index, contact),
          title: Text(name),
          leading: contact.photo == null
              ? null
              : CircleAvatar(
                  backgroundImage: MemoryImage(contact.photo!),
                ),
          trailing: selectedContactsIndexList.contains(index)
              ? const Icon(
                  Icons.done,
                  color: AppColors.black,
                )
              : null,
        ),
        const Divider(
          indent: 50.0,
          endIndent: 50.0,
          height: 1.0,
        ),
      ],
    );
  }
}
