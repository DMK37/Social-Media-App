import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          children: [
            CircleAvatar(
              radius: 8,
              backgroundImage: AssetImage("images/google.png"),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                    ),
                    child: Text(
                      "username",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )))
          ],
        ),
        ClipRRect(child: Image(image: AssetImage("images/google.png"))),
      ]),
    );
  }
}
