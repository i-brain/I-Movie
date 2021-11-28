import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:i_movie/data/contarctors/i_sign_up_repository.dart';
import 'package:i_movie/data/data_sources/sign_up_data_source.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:multiple_result/multiple_result.dart';

class SignUpRepository implements ISignUpRepository {
  final dataSource = SignUpDataSource();

  @override
  Future<Result<String, void>> signUpUser(User user) async {
    try {
      await dataSource.registerUser(user);
      return const Success(null);
    } on SocketException {
      return const Error('No Internet Connection');
    } on fb.FirebaseAuthException catch (error) {
      if (error.code == "email-already-in-use") {
        return const Error('This email is already in use');
      }
    } catch (error) {
      return const Error('Unknown Error happened');
    }
    return const Error('Unknown Error happened');
  }
}
