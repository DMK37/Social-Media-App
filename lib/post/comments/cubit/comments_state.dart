import 'package:social_media/data/models/comment_model.dart';

abstract class CommentsState {}

class CommentsLoadingState extends CommentsState {}

class CommentsLoadedState extends CommentsState {
  final List<CommentModel> comments;

  CommentsLoadedState(this.comments);
}

class CommentsErrorState extends CommentsState {
  final String errorMessage;

  CommentsErrorState(this.errorMessage);
}