import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/data/models/user_model.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    if (await _isUsernameTaken(user.username) != null) {
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
    final u = await _isUsernameTaken(user.username);
    if (u != null && u.userId != user.userId) {
      throw Exception("Username already taken");
    }
    await _db.collection('users').doc(user.userId).update(user.toJson());
    return user;
  }

  Future<UserModel?> _isUsernameTaken(String username) async {
    final userSnapshot = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    return userSnapshot.docs.isNotEmpty
        ? UserModel.fromSnapshot(userSnapshot.docs.first)
        : null;
  }

  Future<void> followUser(String userId, String followUserId) async {
    await _db.collection('users').doc(userId).update({
      'following': FieldValue.arrayUnion([followUserId])
    });
    await _db.collection('users').doc(followUserId).update({
      'followers': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> unfollowUser(String userId, String unfollowUserId) async {
    await _db.collection('users').doc(userId).update({
      'following': FieldValue.arrayRemove([unfollowUserId])
    });
    await _db.collection('users').doc(unfollowUserId).update({
      'followers': FieldValue.arrayRemove([userId])
    });
  }

  Future<List<UserModel>> searchUser(String username) async {
    final userSnapshot = await _db
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: username)
        .where('username', isLessThan: '${username}z')
        .limit(20)
        .get();
    if (userSnapshot.docs.isNotEmpty) {
      return userSnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    }
    return [];
  }
}
