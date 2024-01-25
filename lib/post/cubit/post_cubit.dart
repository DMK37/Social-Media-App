import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/post_repository.dart';
import 'package:social_media/data/repository/user_repository.dart';
import 'package:social_media/post/cubit/post_cubit_state.dart';

class PostCubit extends Cubit<PostState> {
  final String postId;
  PostRepository postRepository = PostRepository();
  UserRepository  userRepository = UserRepository();
  PostCubit(this.postId) : super(PostLoadingState());
  PostModel? post;

  Future<void> fetchPost() async {
    emit(PostLoadingState());
    post = await postRepository.getPost(postId);
    if (post == null) {
      emit(PostErrorState('Post not found'));
    } else {
      final UserModel? user = await userRepository.getUser(post!.userId);
      if (user == null) {
        emit(PostErrorState('User not found'));
        return;
      }
      emit(PostLoadedState(post!, user));
    }
  }

  Future<void> likePost(String userId) async {
    if (post == null) {
      return;
    }
    try {
      await postRepository.likePost(postId, userId);
      final UserModel? user = await userRepository.getUser(post!.userId);
      if (user == null) {
        emit(PostErrorState('User not found'));
        return;
      }
      emit(PostLoadedState(post!, user));
    } catch (e) {
      PostErrorState(e.toString());
    }
  }

  Future<void> unlikePost(String userId) async {
    if (post == null) {
      return;
    }
    try {
      await postRepository.unlikePost(postId, userId);
      final UserModel? user = await userRepository.getUser(post!.userId);
      if (user == null) {
        emit(PostErrorState('User not found'));
        return;
      }
      emit(PostLoadedState(post!, user));
    } catch (e) {
      PostErrorState(e.toString());
    }
  }

}
