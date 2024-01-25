import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/profile_post_card.dart';
import 'package:social_media/home/cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedTag = "All";
  List<String> tags = [
    "All",
    "Portraits",
    "Landscapes",
    "StreetStyle",
    "Macro",
    "Monochrome",
    "Nature",
    "Travel",
    "Nighttime",
    "Fashion",
    "Abstract",
    "Film",
    "Wildlife",
    "Urban",
    "Events",
    "Aerial",
    "Underwater",
    "Tips",
    "Gear",
    "Inspiration",
    "Editing",
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          context.go('/login');
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthenticatedState) {
            return BlocProvider(
                create: (context) => HomeCubit(
                    (context.read<AuthCubit>().state as AuthenticatedState)
                        .user)
                  ..getPosts(selectedTag),
                child: Scaffold(
                  body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                            //title: Text('Your Title'),
                            title: const Image(
                              image: AssetImage("images/photocraft.png"),
                              height: 50,
                              width: 50,
                            ),
                            floating: true,
                            snap: true,
                            bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(40),
                              child: SizedBox(
                                height: 50,
                                //width: 100,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: tags.map((tag) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (tag == selectedTag) {
                                          return;
                                        }

                                        context.read<HomeCubit>().getPosts(tag);

                                        setState(() {
                                          selectedTag = tag;
                                        });
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 8),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 12),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                border: Border.all(
                                                    color: tag == selectedTag
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .tertiary
                                                        : Colors.grey,
                                                    width: 2)),
                                            child: Text(
                                              tag,
                                              style: TextStyle(
                                                  color: tag == selectedTag
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .tertiary
                                                      : Colors.grey,
                                                  fontSize: 14),
                                            ),
                                          )),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),
                      ];
                    },
                    body: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                      switch (state) {
                        case HomeLoadingState():
                          return const Center(
                              child: CircularProgressIndicator());
                        case HomeLoadedState(posts: final posts):
                          return RefreshIndicator(
                            onRefresh: () async {
                              context.read<AuthCubit>().isAuthenticated();

                              context.read<HomeCubit>().getPosts(selectedTag);
                            },
                            child: MasonryGridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 15,
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .push('/post/${posts[index].postId}');
                                  },
                                  child: ProfilePostCard(
                                    post: posts[index],
                                  ),
                                );
                              },
                            ),
                          );
                        case HomeErrorState(errorMessage: final errorMessage):
                          return Center(child: Text(errorMessage));
                        default:
                          return const SizedBox.shrink();
                      }
                    }),
                  ),
                ));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
