import 'package:flutter/cupertino.dart';
import 'package:messenger/DataProvider/ApiProvider.dart';
import 'package:messenger/Model/LoginModel.dart';

class LoginRepository {
  final ApiProvider apiProvider;

  LoginRepository({@required this.apiProvider}) : assert((apiProvider != null));

  Future<Login> login(String userName, String password) async {
    var response = await apiProvider
        .post('auth/login?username=$userName&password=$password');
    if (response.statusCode == 200) {
      return Login();
    }
    return Login.fromJson(response.data);
  }
}
