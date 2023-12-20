import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String username;

  const UserModel({
    required this.userId,
    required this.email,
    required this.username,
    required this.name
  });

  @override
  List<Object?> get props => [userId, email, name];
}
