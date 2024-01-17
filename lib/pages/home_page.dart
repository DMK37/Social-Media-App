import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/profile_post_card.dart';
import 'package:social_media/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            return Scaffold(
              appBar: AppBar(
                title: const Image(
                  image: AssetImage("images/photocraft.png"),
                  height: 50,
                  width: 50,
                ),
              ),
              body: BlocProvider(
                create: (context) => HomeCubit(
                    (context.read<AuthCubit>().state as AuthenticatedState)
                        .user)
                  ..getPosts(),
                child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                  switch (state) {
                    case HomeLoadingState():
                      return const Center(child: CircularProgressIndicator());
                    case HomeLoadedState(posts: final posts):
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<AuthCubit>().isAuthenticated();
                          context.read<HomeCubit>().getPosts();
                        },
                        child: MasonryGridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 15,
                          itemCount: posts.length,
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
                    case HomeErrorState(errorMessage: final errorMessage):
                      return Center(child: Text(errorMessage));
                    default:
                      return const SizedBox.shrink();
                  }
                }),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
