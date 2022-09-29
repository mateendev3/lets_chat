import 'package:flutter/material.dart';

class ErrorViewer extends StatelessWidget {
  const ErrorViewer({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        error,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
