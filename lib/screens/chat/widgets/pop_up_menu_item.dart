import 'package:flutter/material.dart';

PopupMenuItem buildPopUpMenuItem(
  IconData icon,
  String text,
  VoidCallback onPressed,
) {
  return PopupMenuItem(
    child: ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onPressed,
    ),
  );
}
