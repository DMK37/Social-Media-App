import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/user_repository.dart';
import 'package:social_media/edit_profile/cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final AuthCubit authCubit;
  final UserRepository userRepository = UserRepository();
  final _storage = FirebaseStorage.instance;
  final picker = ImagePicker();
  String prevUrl;
  File? imageFile;
  EditProfileCubit({required this.authCubit, required this.prevUrl})
      : super(EditProfileInitialState()) ;

  Future<void> pickProfileImage(ImageSource source) async {
    emit(EditProfileLoadingState());
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      emit(EditProfileInitialState());
    } else {
      emit(EditProfileInitialState());
      //emit(EditProfileErrorState(errorMessage: 'no image selected'));
    }
  }

  Future<void> updateProfile(
    String firstName,
    String lastName,
    String username,
    String about,
  ) async {
    emit(EditProfileLoadingState());
    UserModel? user = (authCubit.state as AuthenticatedState).user;
    String? url;
    if (imageFile != null) {
      final ref = _storage.ref().child('avatars/${user.userId}.jpg');
      await ref.putFile(imageFile!);
      url = await ref.getDownloadURL();
    }
    user = UserModel(
        userId: user.userId,
        email: user.email,
        username: username,
        firstName: firstName,
        lastName: lastName,
        about: about,
        profileImageUrl: url ?? user.profileImageUrl);
    user = await userRepository.updateUser(user);
    if (user != null) {
      await authCubit.isAuthenticated();
      emit(EditProfileSuccessState());
    } else {
      emit(EditProfileErrorState(errorMessage: 'update profile failed'));
    }
  }
}
