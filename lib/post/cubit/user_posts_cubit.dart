import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/data/repository/post_repository.dart';
import 'package:social_media/post/cubit/user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  final String userId;
  PostRepository postRepository = PostRepository();

  UserPostsCubit(this.userId) : super(UserPostsEmptyState());

  void fetchPosts() async {
    emit(UserPostsLoadingState());
    final posts = await postRepository.getPosts(userId);
    if (posts.isEmpty) {
      emit(UserPostsEmptyState());
    } else {
      emit(UserPostsLoadedState(posts));
    }
  }
}
