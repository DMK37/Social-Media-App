import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/user_repository.dart';
import 'package:social_media/edit_profile/cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final AuthCubit authCubit;
  final UserRepository userRepository = UserRepository();
  EditProfileCubit({required this.authCubit})
      : super(EditProfileInitialState());

  Future<void> updateProfile(
      String firstName, String lastName, String username, String about) async {
    UserModel prevUser = (authCubit.state as AuthenticatedState).user;
    UserModel? user = UserModel(
        userId: prevUser.userId,
        email: prevUser.email,
        username: username,
        firstName: firstName,
        lastName: lastName,
        about: about);
    user = await userRepository.updateUser(user);
    if (user != null) {
      await authCubit.isAuthenticated();
      emit(EditProfileSuccessState());
    } else {
      emit(EditProfileErrorState(errorMessage: 'update profile failed'));
    }
  }
}
