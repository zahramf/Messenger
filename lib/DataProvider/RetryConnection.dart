import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:messenger/DataProvider/DioConnectRequest.dart';

class RetryOnConnectionChangeInceptor extends Interceptor {
  //======================================================
  final DioConnectivityRequestRetry requestRetry;
  //======================================================

  RetryOnConnectionChangeInceptor({@required this.requestRetry});

  @override
  Future onError(DioError err) async {
    if (this._shouldRetry(err)) {
      try {
        return this.requestRetry.schedualRequestRetry(err.request);
      } catch (_) {
        print(_);
        return _;
      }
    }
    return err;
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT &&
        err.error != null &&
        err.error is SocketException;
  }
}
