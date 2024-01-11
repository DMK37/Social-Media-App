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

  void fetchPost() async {
    emit(PostLoadingState());
    final PostModel? post = await postRepository.getPost(postId);
    if (post == null) {
      emit(PostErrorState('Post not found'));
    } else {
      final UserModel? user = await userRepository.getUser(post.userId);
      if (user == null) {
        emit(PostErrorState('User not found'));
        return;
      }
      emit(PostLoadedState(post, user));
    }
  }
}
