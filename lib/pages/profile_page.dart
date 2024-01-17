import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/profile_post_card.dart';
import 'package:social_media/post/cubit/user_posts_cubit.dart';
import 'package:social_media/post/cubit/user_posts_state.dart';
import 'package:social_media/theme/theme_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          context.go('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Image(
            image: AssetImage("images/photocraft.png"),
            height: 50,
            width: 50,
          ),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            BlocBuilder<ThemeCubit, ThemeData>(
                                builder: (context, state) {
                              if (state.brightness == Brightness.light) {
                                return ListTile(
                                  leading: const Icon(Icons.dark_mode),
                                  title: const Text('Change theme'),
                                  onTap: () {
                                    context.read<ThemeCubit>().changeTheme();
                                  },
                                );
                              }
                              return ListTile(
                                leading: const Icon(Icons.light_mode),
                                title: const Text('Change theme'),
                                onTap: () {
                                  context.read<ThemeCubit>().changeTheme();
                                },
                              );
                            }),
                            ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text('Logout'),
                              onTap: () {
                                context.read<AuthCubit>().logout();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.bars));
            }),
          ],
        ),
        body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          switch (state) {
            case AuthLoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case UnauthenticatedState():
              return const Center(
                child: Text('Unauthenticated'),
              );
            case AuthFailureState(errorMessage: final errorMessage):
              return Center(
                child: Text(errorMessage),
              );
            case AuthenticatedState(user: final user):
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<AuthCubit>().isAuthenticated();
                  context.read<ProfilePostsCubit>().fetchPosts();
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
                                loadingBuilder: (BuildContext context,
                                    Widget child,
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${user.followers.length} followers',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  " • ",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  '${user.following.length} following',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ]),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 150,
                                child: TextButton(
                                  onPressed: () {
                                    context.go('/edit-profile');
                                    //StatefulNavigationShell.of(context).goBranch();;
                                  },
                                  style:
                                      Theme.of(context).textButtonTheme.style,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      'Edit Profile',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    const SliverAppBar(
                      title: Text('Posts'),
                      pinned: true,
                      automaticallyImplyLeading: false,
                    ),
                    Builder(builder: (context) {
                      context.read<ProfilePostsCubit>().fetchPosts();
                      return BlocBuilder<ProfilePostsCubit, UserPostsState>(
                        builder: (context, state) {
                          switch (state) {
                            case UserPostsLoadingState():
                              return const SliverToBoxAdapter(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            case UserPostsEmptyState():
                              return const SliverToBoxAdapter(
                                child: Center(
                                  child: Text('No posts'),
                                ),
                              );
                            case UserPostsLoadedState(posts: final posts):
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
                                        context.push(
                                            '/post/${posts[index].postId}');
                                      },
                                      child: ProfilePostCard(
                                        post: posts[index],
                                      ),
                                    );
                                  },
                                ),
                              );
                            default:
                              return const SliverToBoxAdapter(
                                child: Center(
                                  child: Text('Something went wrong'),
                                ),
                              );
                          }
                        },
                      );
                    }),
                  ],
                ),
              );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        }),
      ),
    );
  }
}
