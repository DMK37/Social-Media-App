import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/post_repository.dart';
import 'package:social_media/data/repository/user_repository.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserModel user;
  final List<PostModel> posts;
  UserLoadedState(this.user, this.posts);
}

class UserErrorState extends UserState {
  final String errorMessage;

  UserErrorState(this.errorMessage);
}

class UserCubit extends Cubit<UserState> {
  final String username;
  UserCubit(this.username) : super(UserLoadingState());
  final UserRepository userRepository = UserRepository();
  final PostRepository postRepository = PostRepository();

  Future<void> getUser() async {
    emit(UserLoadingState());
    try {
      final user = await userRepository.getUserByUsername(username);

      if (user == null) {
        emit(UserErrorState("User not found"));
        return;
      }
      final posts = await postRepository.getPosts(user.userId!);
      emit(UserLoadedState(user, posts));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
