import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/select_receiver_contacts_controller.dart';

class ContactsList extends ConsumerStatefulWidget {
  const ContactsList({
    super.key,
    required this.contactsList,
  });

  final List<Contact> contactsList;

  @override
  ConsumerState<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends ConsumerState<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.contactsList.length,
      itemBuilder: (context, index) => getListItem(
        widget.contactsList[index],
      ),
    );
  }

  Widget getListItem(Contact contact) {
    String name = contact.displayName;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: () => _selectContact(contact),
          title: Text(name),
          leading: contact.photo == null
              ? null
              : CircleAvatar(
                  backgroundImage: MemoryImage(contact.photo!),
                ),
        ),
        const Divider(
          indent: 50.0,
          endIndent: 50.0,
          height: 1.0,
        ),
      ],
    );
  }

  void _selectContact(Contact contact) async {
    await ref
        .read(selectReceiverContactControllerProvider)
        .selectReceiverContact(
          mounted,
          context,
          contact: contact,
        );
  }
}
