import 'package:flutter/material.dart';

class SuccessSnackBar extends StatelessWidget {
  final String message;
  const SuccessSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 56, 124, 59),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          message,
          style: Theme.of(context).textTheme.headlineMedium,
        ));
  }
}
