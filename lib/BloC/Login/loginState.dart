part of 'loginBloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {}

class LoginStateInProgress extends LoginState {}

class LoginStateError extends LoginState {}

class LoginStateCompleted extends LoginState {}
