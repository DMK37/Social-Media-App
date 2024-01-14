import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/post/comments/cubit/comments_cubit.dart';
import 'package:social_media/post/comments/cubit/comments_state.dart';
import 'package:social_media/views/comments_view.dart';

class CommentsPage extends StatelessWidget {
  final String postId;
  const CommentsPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CommentsCubit()..getComments(postId),
        child: BlocBuilder<CommentsCubit, CommentsState>(
          builder: (context, state) {
            switch (state) {
              case CommentsLoadingState():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case CommentsErrorState(errorMessage: final errorMessage):
                return Center(
                  child: Text(errorMessage),
                );
              case CommentsLoadedState(comments: final comments):
                return CommentsView(
                  postId: postId,
                  comments: comments,
                  user: (context.read<AuthCubit>().state as AuthenticatedState)
                      .user,
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ));
  }
}
