import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/data/models/user_model.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection('users').doc(user.userId).set(user.toJson());
  }

  Future<UserModel?> getUser(String userId) async {
    final user = await _db.collection('users').doc(userId).get();
    if (user.exists) {
      return UserModel.fromSnapshot(user);
    }
    return null;
  }

  Future<UserModel?> updateUser(UserModel user) async {
    await _db.collection('users').doc(user.userId).update(user.toJson());
    return user;
  }
}
