import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/components/profile_post_card.dart';
import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';

class UserView extends StatelessWidget {
  final UserModel user;
  final List<PostModel> posts;
  const UserView({super.key, required this.user, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Image(
            image: AssetImage("images/photocraft.png"),
            height: 50,
            width: 50,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<AuthCubit>().isAuthenticated();
          },
          child: CustomScrollView(
            slivers: <Widget>[
              // Your widgets
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: ClipOval(
                        child: Image.network(
                          user.profileImageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                                width: 100,
                                height: 100,
                                child: Shimmer.fromColors(
                                    baseColor: Colors.grey[800]!,
                                    highlightColor: Colors.grey[700]!,
                                    child: Container(
                                      color: Colors.grey[800],
                                    )));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.getFullName(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "@${user.username}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.about,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        '0 followers',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        " • ",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        '0 following',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 120,
                          child: TextButton(
                            onPressed: () {
                              //context.go('/edit-profile');
                              
                            },
                            style: Theme.of(context).textButtonTheme.style,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                'Follow',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SliverAppBar(
                title: Text('Posts'),
                pinned: true,
                automaticallyImplyLeading: false,
              ),
              posts.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'No posts yet',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    )
                  : Builder(builder: (context) {
                      return SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: SliverMasonryGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 15,
                          childCount: posts.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.push('/post/${posts[index].postId}');
                              },
                              child: ProfilePostCard(
                                post: posts[index],
                              ),
                            );
                          },
                        ),
                      );
                    }),
            ],
          ),
        ));
  }
}
