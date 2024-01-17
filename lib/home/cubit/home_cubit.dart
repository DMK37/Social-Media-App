import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/post_repository.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<PostModel> posts;
  HomeLoadedState(this.posts);
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);
}

class HomeCubit extends Cubit<HomeState> {
  final UserModel user;
  HomeCubit(this.user) : super(HomeLoadingState());
  final PostRepository postRepository = PostRepository();

  Future<void> getPosts() async {
    emit(HomeLoadingState());
    try {
      if(user.following.isEmpty) {
        emit(HomeLoadedState([]));
        return;
      }
      final posts = await postRepository.getPostsFromFollowing(user.following);
      emit(HomeLoadedState(posts));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}