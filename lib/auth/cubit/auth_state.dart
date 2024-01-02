import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/data/models/user_model.dart';

abstract class AuthState {}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final UserModel user;

  AuthenticatedState({required this.user});
}

class UnauthenticatedState extends AuthState {}

class ProviderSignUpState extends AuthState {
  final UserCredential credential;
  ProviderSignUpState({required this.credential});
}

class AuthFailureState extends AuthState {
  final String errorMessage;

  AuthFailureState({required this.errorMessage});
}
