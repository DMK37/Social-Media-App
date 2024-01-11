import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/post/cubit/post_cubit.dart';
import 'package:social_media/post/cubit/post_cubit_state.dart';
import 'package:social_media/views/post_view.dart';

class PostPage extends StatelessWidget {
  final String postId;

  const PostPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
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
      body: BlocProvider(
        create: (context) =>
            PostCubit(postId)..fetchPost(), // Create an instance of PostCubit
        child: BlocBuilder<PostCubit, PostState>(builder: (context, state) {
          switch (state) {
            case PostLoadingState():
              return const Center(child: CircularProgressIndicator());
            case PostLoadedState(post: final post, user: final user):
              return PostView(post: post, user: user);
            case PostErrorState(message: final message):
              return Center(child: Text(message));
            default:
              return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
