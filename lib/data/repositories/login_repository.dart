import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:i_movie/data/contarctors/i_login_repository.dart';
import 'package:i_movie/data/data_sources/login_data_source.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:multiple_result/multiple_result.dart';

class LoginRepository implements ILoginRepository {
  final dataSource = LoginDataSource();

  @override
  Future<Result<String, void>> signInUser(User user) async {
    try {
      await dataSource.loginUser(user);
      return const Success(null);
    } on SocketException {
      return const Error('No Internet Connection');
    } on fb.FirebaseAuthException catch (error) {
      switch (error.code) {
        case "user-not-found":
          return const Error('User doesn\'t exist');
        case "wrong-password":
          return const Error('Password is wrong');
        case "too-many-requests":
          return const Error(
            'Too many requests have been made. Try again later',
          );
        default:
          const Error('Unknown error happened');
      }
    }
    return const Error('Unknown error happened');
  }
}
