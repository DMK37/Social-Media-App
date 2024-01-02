import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/auth_repository.dart';
import 'package:social_media/data/repository/user_repository.dart';

class FirebaseAuthRepository extends AuthRepository {
  final _auth = FirebaseAuth.instance;
  final _user = UserRepository();
  final _storage = FirebaseStorage.instance;

  @override
  Future<UserModel?> currentUser() async {
    final User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      return await _user.getUser(firebaseUser.uid);
    }
    return null;
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      //print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    final User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
    }
  }

  @override
  Future<UserModel?> signUp(String email, String password, String username,
      String firstName, String lastName) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? firebaseUser = userCredential.user;
      final ref = _storage.ref().child('avatars/defaultAvatar.jpg');
      String url = await ref.getDownloadURL();
      if (firebaseUser != null) {
        UserModel user = UserModel(
            userId: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            username: username,
            firstName: firstName,
            lastName: lastName,
            about: '',
            profileImageUrl: url);
        _user.createUser(user);
        return user;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final doc =
          await FirebaseFirestore.instance.collection("users").doc().get();
      if (doc.exists) {
        return await _auth.signInWithCredential(credential);
      }
      return null;
      // Once signed in, return the UserCredential
      //return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      rethrow;
      //print(e.toString());
      //return null;
    }
  }

  @override
  Future<void> signInWithFacebook() async {
    //await FacebookAuth.instance.logOut();
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(facebookAuthCredential);
    //print(res);
  }
}
