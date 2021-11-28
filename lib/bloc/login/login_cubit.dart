import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/data/repositories/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.repository}) : super(LoginInitial());

  final LoginRepository repository;

  Future<void> login(User user) async {
    emit(LoginLoading());
    final succesOrError = await repository.signInUser(user);
    if (succesOrError.isSuccess()) {
      emit(LoginSuccess());
    } else {
      emit(LoginError(errorMessage: succesOrError.getError()!));
    }
  }
}
