import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({
    super.key,
    required this.contactsList,
  });

  final List<Contact> contactsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactsList.length,
      itemBuilder: (context, index) => getListItem(
        contactsList[index],
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
}
