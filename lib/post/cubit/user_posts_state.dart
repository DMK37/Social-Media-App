import 'package:social_media/data/models/post_model.dart';

abstract class UserPostsState {}

class UserPostsEmptyState extends UserPostsState {}

class UserPostsLoadingState extends UserPostsState {}

class UserPostsLoadedState extends UserPostsState {
  final List<PostModel> posts;

  UserPostsLoadedState(this.posts);
}

class UserPostsErrorState extends UserPostsState {
  final String message;

  UserPostsErrorState(this.message);
}