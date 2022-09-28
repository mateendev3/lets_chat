import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Error Screen',
        ),
      ),
      body: Center(
        child: Text(
          error,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
