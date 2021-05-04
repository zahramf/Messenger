import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioConnectivityRequestRetry {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetry(
      {@required this.dio, @required this.connectivity});

  Future<Response> schedualRequestRetry(RequestOptions requestOption) async {
    //=========================================================
    final responseCompleter = Completer<Response>();
    StreamSubscription streamSubscription;
    //=========================================================

    streamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      // when we are connected, we have to request again
      if (connectivityResult != ConnectivityResult.none) {
        streamSubscription.cancel();
        responseCompleter.complete(this.dio.request(requestOption.path,
            cancelToken: requestOption.cancelToken,
            data: requestOption.data,
            onReceiveProgress: requestOption.onReceiveProgress,
            queryParameters: requestOption.queryParameters,
            options: requestOption));
      }
    });

    return responseCompleter.future;
  }
}
