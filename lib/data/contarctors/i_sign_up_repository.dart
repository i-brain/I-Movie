import 'package:i_movie/data/models/user.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ISignUpRepository {
  Future<Result<String, void>> signUpUser(User user);
}
