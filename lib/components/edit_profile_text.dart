import 'package:flutter/material.dart';

class EditProfileText extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const EditProfileText(
      {super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8.0),
              )),
        ],
      ),
    );
  }
}
