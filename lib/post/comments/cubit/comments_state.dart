import 'package:social_media/data/models/display_comment_model.dart';

abstract class CommentsState {}

class CommentsLoadingState extends CommentsState {}

class CommentsLoadedState extends CommentsState {
  final List<DisplayCommentModel> comments;

  CommentsLoadedState(this.comments);
}

class CommentsErrorState extends CommentsState {
  final String errorMessage;

  CommentsErrorState(this.errorMessage);
}