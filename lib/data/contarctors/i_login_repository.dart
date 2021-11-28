import 'package:i_movie/data/models/user.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ILoginRepository {
  Future<Result<String, void>> signInUser(User user);
}
