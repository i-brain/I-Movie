import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String? username;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String? id;

  User({
    this.username = '',
    required this.email,
    required this.password,
    this.id = '',
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      email: data['email'],
      password: data['password'],
      id: data['id'],
      username: data['username'],
    );
  }
}
