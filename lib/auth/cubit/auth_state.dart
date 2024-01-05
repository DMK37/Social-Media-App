import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/data/models/user_model.dart';

abstract class AuthState {}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final UserModel user;
  ClipOval? image;
  AuthenticatedState({required this.user}) {
    image = ClipOval(
        child: Image.network(
      user.profileImageUrl,
      height: 100,
      width: 100,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    ));
  }
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
