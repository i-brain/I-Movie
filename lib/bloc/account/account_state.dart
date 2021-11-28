part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountSuccess extends AccountState {}

class AccountLoading extends AccountState {}

class AccountError extends AccountState {
  final String errorMessage;

  const AccountError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
