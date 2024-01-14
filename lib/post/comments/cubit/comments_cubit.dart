import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/data/models/display_comment_model.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/post_repository.dart';
import 'package:social_media/data/repository/user_repository.dart';
import 'package:social_media/post/comments/cubit/comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsLoadedState([]));
  final PostRepository postRepository = PostRepository();
  final UserRepository userRepository = UserRepository();

  Future<void> getComments(String postId) async {
    emit(CommentsLoadingState());
    try {
      final post = await postRepository.getPost(postId);  
      if (post == null) {
        emit(CommentsErrorState("Post not found")); 
      }
      List<DisplayCommentModel> comments = [];
      for (var comment in post!.comments) {
        final user = await userRepository.getUser(comment.userId);
        comments.add(DisplayCommentModel(
          comment: comment.comment,
          avatar: user!.profileImageUrl,
          username: user.username,
          timestamp: comment.timestamp,
        ));
      }
      emit(CommentsLoadedState(comments));
    } catch (e) {
      emit(CommentsErrorState(e.toString()));
    }
  }

  Future<void> addComment(String postId, String comment, UserModel user) async {
    emit(CommentsLoadingState());
    try {
      final comm = await postRepository.addComment(postId, comment, user);
      List<DisplayCommentModel> comments = [];
      for (var comment in comm) {
        final user = await userRepository.getUser(comment.userId);
        comments.add(DisplayCommentModel(
          comment: comment.comment,
          avatar: user!.profileImageUrl,
          username: user.username,
          timestamp: comment.timestamp,
        ));
      }
      emit(CommentsLoadedState(comments));
    } catch (e) {
      emit(CommentsErrorState(e.toString()));
    }
  }
}
