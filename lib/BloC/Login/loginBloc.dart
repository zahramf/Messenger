import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:messenger/Model/LoginModel.dart';
import 'package:messenger/Repository/LoginRepository.dart';

import '../../MPref.dart';

part 'loginEvent.dart';
part 'loginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(LoginStateInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEventLogin) {
      yield LoginStateInProgress();
//send request
      Login result;

      result = await loginRepository.login(event.userName, event.pass);

      if (result != null) {
        if (result.accessToken != null) {
          MPref.setString('AccessToken', result.accessToken);
          // var token = MPref.getString("AccessToken");
          MPref.setString(
              'FullName', result.user.fullname + " " + result.user.lastname);
          MPref.setString('FirstName', result.user.fullname);
          MPref.setString('LastName', result.user.lastname);
          MPref.setString('Image', result.user.pathCover);
          MPref.setString('UserName', result.user.username);
          MPref.setString('PostTitle', result.user.post.title);

          yield LoginStateCompleted();
        }
      }
      // yield LoginStateCompleted();
    } else if (event is LoginEventLogOut) {
      MPref.clear();
      yield LoginStateInitial();
    }
  }
}
