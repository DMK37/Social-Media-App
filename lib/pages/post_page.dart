import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/views/post_view.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Image(
          image: AssetImage("images/photocraft.png"),
          height: 50,
          width: 50,
        ),
      ),
      body: PostView(),
    );
  }
}
