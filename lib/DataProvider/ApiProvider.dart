import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:messenger/BloC/Login/loginBloc.dart';
import 'package:messenger/DataProvider/DioConnectRequest.dart';

import 'package:messenger/DataProvider/RetryConnection.dart';
//import 'package:messenger/BloC/Login/loginEvent.dart';
//import 'package:messenger/BloC/Login/loginState.dart';

class ApiProvider {
  //=============================================================
  final String _baseUrl =
      // MPref.getString("ApiAddress");
      // "https://api.falsepeti.com/api";
      "http://mailservice.markazfeqhi.com/api/";
  LoginBloc loginBloc;
  //=============================================================

  ApiProvider({this.loginBloc});

  Dio getBaseDio() {
    // print(MPref.getString("ApiAddress") +
    //     "////////////////////////////////////////////");
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tYWlsc2VydmljZS5tYXJrYXpmZXFoaS5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MzA1ODA4OTEsImV4cCI6MTYzMTQ0NDg5MSwibmJmIjoxNjMwNTgwODkxLCJqdGkiOiI3bTdEbUJDV2lqWGV2TGl4Iiwic3ViIjo3MzgsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.HW-G6Cp991k4AlvSBcf1Ap4omHWXCYwNhq2x4GyfXec";

    //MPref.getString("AccessToken");
    Dio dio =
        Dio(BaseOptions(baseUrl: "http://mailservice.markazfeqhi.com/api/",
            // MPref.getString("ApiAddress"),

            // connectTimeout: 5000,
            headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          // "Content-Type": "multipart/form-data"
        }));

    // if the connection lost (wifi or mobile data)
    // with this interceptor we can retry that request
    // :)
    dio.interceptors.add(RetryOnConnectionChangeInceptor(
        requestRetry: DioConnectivityRequestRetry(
            dio: Dio(), connectivity: Connectivity())));

    return dio;
  }

  Future<Response> get(String url, {Map<String, dynamic> body}) async {
    return await getBaseDio().get(url).catchError(
      (error) {
        // if ((error.response as Response).statusCode == 401) {
        // var apiProvider = new ApiProvider();
        // UserBloc(
        //   userRepository: new UserRepository(apiProvider: apiProvider),
        //   fortuneRepository: new FortuneRepository(
        //     apiProvider: apiProvider,
        //   ),
        // )
        try {
          // ignore: close_sinks
          // var d = BlocProvider.of<UserBloc>(context);

          // var d = BlocProvider.of<FortuneBloc>(context);\
          if ((error.response as Response).statusCode == 401) {
            /* if (this.loginBloc.state != UserStateUnAuthorized()) {
              this.loginBloc.add(UserEventUnAuthorized());
            }*/
          }
          // d.add(UserEventUnAuthorized());
        } catch (_) {
          print(_);
        }
        // }
        return error.response;
      },
    );
  }

  Future<Response> post(String url, {Map<String, dynamic> body}) async {
    return await getBaseDio()
        .post(url, queryParameters: body)
        .catchError((error) {
      try {
        // ignore: close_sinks
        // var d = BlocProvider.of<UserBloc>(context);

        // var d = BlocProvider.of<FortuneBloc>(context);
        if ((error.response as Response).statusCode == 401) {
          /* if (this.loginBloc.state != UserStateUnAuthorized()) {
            this.loginBloc.add(UserEventUnAuthorized());
          }*/
        }
        // d.add(UserEventUnAuthorized());
      } catch (_) {
        print(_);
      }
      return error.response;
    });
    // } catch (_) {
    //   print("ApiProvider post Error => " + _.toString());
    // }
    // return new Response(statusCode: -1);
  }

  Future<Response> postWithFile(String url, dynamic body) async {
    return await getBaseDio()
        .post(
      url,
      data: body,
    )
        .catchError(
      (error) {
        return error.response;
      },
    );
  }
}
