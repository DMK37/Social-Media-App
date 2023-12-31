abstract class EditProfileState {}

class EditProfileInitialState extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileSuccessState extends EditProfileState {}

class EditProfileErrorState extends EditProfileState {
  final String errorMessage;

  EditProfileErrorState({required this.errorMessage});
}