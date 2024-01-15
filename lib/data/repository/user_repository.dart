import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/data/models/user_model.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    if (await _isUsernameTaken(user.username)) {
      throw Exception("Username already taken");
    }
    await _db.collection('users').doc(user.userId).set(user.toJson());
  }

  Future<UserModel?> getUser(String userId) async {
    final user = await _db.collection('users').doc(userId).get();
    if (user.exists) {
      return UserModel.fromSnapshot(user);
    }
    return null;
  }

  Future<UserModel?> getUserByUsername(String username) async {
    final userSnapshot = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    if (userSnapshot.docs.isNotEmpty) {
      return UserModel.fromSnapshot(userSnapshot.docs.first);
    }
    return null;
  }

  Future<UserModel?> updateUser(UserModel user) async {
    if (await _isUsernameTaken(user.username)) {
      throw Exception("Username already taken");
    }
    await _db.collection('users').doc(user.userId).update(user.toJson());
    return user;
  }

  Future<bool> _isUsernameTaken(String username) async {
    final userSnapshot = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    return userSnapshot.docs.isNotEmpty;
  }
}
