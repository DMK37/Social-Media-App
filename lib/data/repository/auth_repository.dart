import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> currentUser();
  Future<void> login(String email, String password);
  Future<UserModel?> signUp(String email, String password, String username,
      String firstName, String lastName);
  Future<void> logout();
  Future<(UserCredential, UserModel?)> signInWithGoogle();
  Future<(UserCredential, UserModel?)> signInWithFacebook();
  Future<UserModel?> continueProviderSignUp(UserCredential credential,
      String firstName, String lastName, String username);
}
