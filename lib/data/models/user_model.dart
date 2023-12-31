import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String about;

  const UserModel({
    this.userId,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.about,
  });

  toJson() => {
        'email': email,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'about': about,
      };

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      userId: document.id,
      email: data['email'],
      username: data['username'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      about: data['about'],
    );
  }
}
