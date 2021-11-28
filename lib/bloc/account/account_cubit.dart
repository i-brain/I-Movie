import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_movie/data/repositories/account_repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({
    required this.accountRepository,
  }) : super(AccountInitial());

  final AccountRepository accountRepository;

  Future<void> updatePassword(String newPassword) async {
    emit(
      AccountLoading(),
    );

    final successOrError = await accountRepository.updatePassword(newPassword);

    if (successOrError.isSuccess()) {
      emit(
        AccountSuccess(),
      );
    } else {
      emit(
        AccountError(errorMessage: successOrError.getError()!),
      );
    }
  }
}
