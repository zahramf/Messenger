import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:messenger/UI/Login/loginScreen.dart';
import 'package:messenger/UI/MainPage/MainScreen.dart';
import 'package:messenger/UI/NewMessage/newMsgScreen.dart';
import 'package:messenger/UI/Search/searchScreen.dart';
import 'package:messenger/UI/ShowMessage/ShowInboxMsg.dart';
import 'package:messenger/UI/ShowMessage/ShowSentMsg.dart';

import 'package:messenger/UI/Splash/splash.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/";
    // MaterialRoute(page: LoginScreen, initial: true, guards: [AuthGuard]),
    MaterialRoute(page: SplashScreen, initial: true),
    CustomRoute(
        page: LoginScreen,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        durationInMilliseconds: 400),
    MaterialRoute(
      // page: MainScreen,
      page: LoginScreen,
    ),

    CustomRoute(
        page: NewMsgScreen,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        durationInMilliseconds: 400),

    CustomRoute(
        page: SearchScreen,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        durationInMilliseconds: 400),
    CustomRoute(
        page: showInboxMsg,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        durationInMilliseconds: 400),
    CustomRoute(
        page: showSentMsg,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        durationInMilliseconds: 400),
  ],
)
class $Router {}
