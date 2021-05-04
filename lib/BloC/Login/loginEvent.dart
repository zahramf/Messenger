part of 'loginBloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventLogin extends LoginEvent {
  final String userName;
  final String pass;

  LoginEventLogin({@required this.userName, @required this.pass});
}

class LoginEventLogOut extends LoginEvent {
  LoginEventLogOut();
}
