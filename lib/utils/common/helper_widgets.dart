import 'package:flutter/material.dart';

/// To add space b/w widgets vertically.
Widget addVerticalSpace(double space) => SizedBox(height: space);

/// To add space b/w widgets horizontally.
Widget addHorizontalSpace(double space) => SizedBox(width: space);

/// To show Snackbar
void showSnackBar(
  BuildContext context, {
  required String content,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
