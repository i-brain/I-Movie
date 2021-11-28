import 'package:i_movie/data/contarctors/i_account_repository.dart';
import 'package:i_movie/data/data_sources/account_data_source.dart';
import 'package:multiple_result/multiple_result.dart';

class AccountRepository implements IAccountRepository {
  final dataSource = AccountDataSource();

  @override
  Future<Result<String, void>> updatePassword(String newPassword) async {
    try {
      await dataSource.updateUserPassword(newPassword);
      return const Success(null);
    } catch (error) {
      return Error(error.toString());
    }
  }
}
