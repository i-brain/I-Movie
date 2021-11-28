import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/data/repositories/sign_up_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.repository,
  }) : super(SignUpInitial());

  SignUpRepository repository;

  Future<void> signUp(User user) async {
    emit(SignUpLoading());
    final succesOrError = await repository.signUpUser(user);
    if (succesOrError.isSuccess()) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpError(errorMessage: succesOrError.getError()!));
    }
  }
}
