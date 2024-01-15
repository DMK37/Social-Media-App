import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/data/repository/post_repository.dart';
import 'package:social_media/post/cubit/user_posts_state.dart';

class ProfilePostsCubit extends Cubit<UserPostsState> {
  final AuthCubit authCubit;
  PostRepository postRepository = PostRepository();

  ProfilePostsCubit({required this.authCubit}) : super(UserPostsEmptyState());

  void fetchPosts() async {
    emit(UserPostsLoadingState());
    if (authCubit.state is AuthenticatedState) {
      final userId = (authCubit.state as AuthenticatedState).user.userId;
      final posts = await postRepository.getPosts(userId!);
      if (posts.isEmpty) {
        emit(UserPostsEmptyState());
      } else {
        emit(UserPostsLoadedState(posts));
      }
    } else {
      emit(UserPostsErrorState("User not authenticated"));
    }
  }
}
