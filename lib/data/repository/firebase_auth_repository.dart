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
            followers: [],
            following: [],
            profileImageUrl: url);
        _user.createUser(user);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<(UserCredential, UserModel?)> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw Exception("cancelled");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user?.uid)
          .get();
      if (doc.exists) {
        return (userCredential, UserModel.fromSnapshot(doc));
      }
      return (userCredential, null);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(UserCredential, UserModel?)> signInWithFacebook() async {
    await FacebookAuth.instance.logOut();
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.cancelled) {
      throw Exception("cancelled");
    }

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    UserCredential userCredential =
        await _auth.signInWithCredential(facebookAuthCredential);
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user?.uid)
        .get();
    if (doc.exists) {
      return (userCredential, UserModel.fromSnapshot(doc));
    }
    return (userCredential, null);
  }

  @override
  Future<UserModel?> continueProviderSignUp(UserCredential credential,
      String firstName, String lastName, String username) async {
    try {
      final User? firebaseUser = credential.user;
      final ref = _storage.ref().child('avatars/defaultAvatar.jpg');
      String url = await ref.getDownloadURL();
      if (firebaseUser != null) {
        UserModel user = UserModel(
            userId: firebaseUser.uid,
            email: firebaseUser.email!,
            username: username,
            firstName: firstName,
            lastName: lastName,
            about: '',
            followers: [],
            following: [],
            profileImageUrl: url);
        _user.createUser(user);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
