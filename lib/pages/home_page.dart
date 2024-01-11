import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/profile_post_card.dart';
import 'package:social_media/data/models/post_model.dart';

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
              body: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 20,
                itemBuilder: (context, index) {
                  //return const PostCard(post: PostModel(),);
                  return Text("qq");
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;
  final double extent;

  Tile({required this.index, required this.extent});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: SizedBox(
        height: extent,
        width: extent,
        child: Center(
          child: Text(
            'Tile $index',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
