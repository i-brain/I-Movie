import 'package:multiple_result/multiple_result.dart';

abstract class IAccountRepository {
  Future<Result<String, void>> updatePassword(String newPassword);
}
