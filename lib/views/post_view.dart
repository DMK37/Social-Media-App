import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';

class PostView extends StatelessWidget {
  final PostModel post;
  final UserModel user;
  const PostView({super.key, required this.post, required this.user});

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
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user.profileImageUrl),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    user.username,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded))
                ],
              ),
            ),
            ClipRRect(
              //height: MediaQuery.of(context).size.height * 0.35,
              borderRadius: BorderRadius.circular(20),
              child: Image.network(post.imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline)),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "123",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  IconButton(
                      onPressed: () {context.push("/post/${post.postId}/comments");},
                      icon: const Icon(FontAwesomeIcons.comment)),
                  Text(
                    post.comments.length.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_border_outlined)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              post.description,
              style: Theme.of(context).textTheme.headlineMedium,
            )),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (var tag in post.tags)
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
              "${post.timestamp.day}/${post.timestamp.month}/${post.timestamp.year}",
              style: const TextStyle(color: Colors.grey, fontSize: 17),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
