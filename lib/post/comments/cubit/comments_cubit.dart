import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/post_repository.dart';
import 'package:social_media/post/comments/cubit/comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsLoadedState([]));
  final PostRepository postRepository = PostRepository();

  Future<void> getComments(String postId) async {
    emit(CommentsLoadingState());
    try {
      final post = await postRepository.getPost(postId);
      if (post == null) {
        emit(CommentsErrorState("Post not found"));
        return;
      }
      emit(CommentsLoadedState(post.comments));
    } catch (e) {
      emit(CommentsErrorState(e.toString()));
    }
  }

  Future<void> addComment(String postId, String comment, UserModel user) async {
    emit(CommentsLoadingState());
    try {
      final comments = await postRepository.addComment(postId, comment, user);
      emit(CommentsLoadedState(comments));
    } catch (e) {
      emit(CommentsErrorState(e.toString()));
    }
  }
}
