import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/data/users/cubit/users_cubit.dart';
import 'package:social_media/views/user_view.dart';

class UserPage extends StatelessWidget {
  final String username;
  const UserPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UserCubit(username)..getUser(),
    child: BlocBuilder<UserCubit,UserState>(builder: (BuildContext context, UserState state) { 
        switch(state) {
          case UserLoadingState():
            return const Center(child: CircularProgressIndicator());
          case UserLoadedState(user: final user, posts: final posts):
            return UserView(user: user, posts: posts);
          case UserErrorState(errorMessage: final errorMessage):
            return Center(child: Text(errorMessage));
          default:
            return const SizedBox.shrink();
        }
     },
    ));
  }
}