import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final PostModel post;
  final UserModel user;
  PostLoadedState(this.post, this.user);
}

class PostErrorState extends PostState {
  final String message;
  PostErrorState(this.message);
}