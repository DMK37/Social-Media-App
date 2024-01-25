import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/post/cubit/post_cubit.dart';

class PostView extends StatefulWidget {
  final PostModel post;
  final UserModel user;
  const PostView({super.key, required this.post, required this.user});


  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
 bool isLiked = false;
  @override
  void initState() {
    super.initState();
    isLiked = widget.post.likes.contains(widget.user.userId);
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.push("/user/${widget.user.username}"),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.user.profileImageUrl),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => context.push("/user/${widget.user.username}"),
                    child: Text(
                      widget.user.username,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ClipRRect(
              //height: MediaQuery.of(context).size.height * 0.35,
              borderRadius: BorderRadius.circular(20),
              child: Image.network(widget.post.imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                          onPressed: () {
                            if (isLiked) {
                              context.read<PostCubit>().unlikePost();
                              widget.post.likes.remove(widget.user.userId);
                              setState(() {
                                isLiked = false;
                              });
                            } else {
                              context.read<PostCubit>().likePost();
                              widget.post.likes.add(widget.user.userId!);
                              setState(() {
                                isLiked = true;
                              });
                            }
                          },
                          icon: isLiked
                              ? const Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.red,
                                )
                              : const Icon(FontAwesomeIcons.heart));
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text( 
                      widget.post.likes.length.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context.push("/post/${widget.post.postId}/comments");
                      },
                      icon: const Icon(FontAwesomeIcons.comment)),
                  Text(
                    widget.post.comments.length.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  //const Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              widget.post.description,
              style: Theme.of(context).textTheme.headlineMedium,
            )),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (var tag in widget.post.tags)
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 2)),
                        child: Text(
                          tag,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 14),
                        ),
                      )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.post.timestamp.day}/${widget.post.timestamp.month}/${widget.post.timestamp.year}",
              style: const TextStyle(color: Colors.grey, fontSize: 17),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
