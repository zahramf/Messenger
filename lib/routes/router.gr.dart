// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:messenger/UI/ShowMessage/ShowSentMsg.dart';
import 'package:messenger/UI/Splash/splash.dart';

import '../UI/Login/loginScreen.dart';
import '../UI/MainPage/MainScreen.dart';
import '../UI/NewMessage/newMsgScreen.dart';
import '../UI/Search/searchScreen.dart';
import '../UI/ShowMessage/ShowInboxMsg.dart';

class Routes {
  static const String splashScreen = '/';
  static const String loginScreen = '/login-screen';
  static const String mainScreen = '/main-screen';
  static const String newMsgScreen = '/new-msg-screen';
  static const String searchScreen = '/search-screen';
  static const String showInboxMsg = '/show-inbox-msg';
  static const String showSentMsg = '/show-sent-msg';

  static const all = <String>{
    splashScreen,
    loginScreen,
    mainScreen,
    newMsgScreen,
    searchScreen,
    showInboxMsg,
    showSentMsg
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.mainScreen, page: MainScreen),
    RouteDef(Routes.newMsgScreen, page: NewMsgScreen),
    RouteDef(Routes.searchScreen, page: SearchScreen),
    RouteDef(Routes.showInboxMsg, page: showInboxMsg),
    RouteDef(Routes.showSentMsg, page: showSentMsg),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    LoginScreen: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 400),
      );
    },
    MainScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainScreen(),
        settings: data,
      );
    },
    NewMsgScreen: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => NewMsgScreen(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 400),
      );
    },
    SearchScreen: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 400),
      );
    },
    showInboxMsg: (data) {
      final args = data.getArgs<showInboxMsgArguments>(
        orElse: () => showInboxMsgArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => showInboxMsg(
          //  key: args.key,
          msgId: args.msgId,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 400),
      );
    },
    showSentMsg: (data) {
      final args = data.getArgs<showSentMsgArguments>(
        orElse: () => showSentMsgArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => showSentMsg(
          //  key: args.key,
          msgId: args.msgId,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 400),
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// showInboxMsg arguments holder class
class showInboxMsgArguments {
  final Key key;
  final int msgId;
  showInboxMsgArguments({this.key, this.msgId});

  // showInboxMsgArguments({this.msgId});
}

class showSentMsgArguments {
  final Key key;
  final int msgId;
  showSentMsgArguments({this.key, this.msgId});

  // showInboxMsgArguments({this.msgId});
}
