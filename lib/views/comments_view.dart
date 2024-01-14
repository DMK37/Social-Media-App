import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/components/my_text_field.dart';
import 'package:social_media/data/models/comment_model.dart';
import 'package:social_media/data/models/display_comment_model.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/post/comments/cubit/comments_cubit.dart';

class CommentsView extends StatefulWidget {
  final List<DisplayCommentModel> comments;
  final UserModel user;
  final String postId;
  const CommentsView({
    super.key,
    required this.postId,
    required this.user,
    required this.comments,
  });

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        child: ListView.builder(
          itemCount: widget.comments.length,
          itemBuilder: (context, index) => Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(widget.comments[index].avatar),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.comments[index].username,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(widget.comments[index].comment,
                          style: Theme.of(context).textTheme.bodyMedium)
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
              height: kToolbarHeight,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(widget.user.profileImageUrl),
                  ),
                  Expanded(
                      child: MyTextField(
                    controller: commentController,
                    hintText: "Add a comment...",
                    obscureText: false,
                  )),
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        if (commentController.text.isNotEmpty) {
                          context.read<CommentsCubit>().addComment(
                              widget.postId,
                              commentController.text,
                              widget.user);
                        }
                      },
                      icon: Icon(Icons.send_rounded,
                          color: Theme.of(context).colorScheme.primary))
                ],
              ))),
    );
  }
}
