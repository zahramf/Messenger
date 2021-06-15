import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Router;
//import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/BloC/MessageList/bloc/message_list_Bloc.dart';
import 'package:messenger/BloC/NewMessage/bloc/new_messageBloc.dart';
import 'package:messenger/BloC/Search/searchBloc.dart';
import 'package:messenger/DataProvider/ApiProvider.dart';
import 'package:messenger/Repository/LoginRepository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:messenger/Repository/MessageRepository.dart';

import 'package:messenger/UI/Login/loginScreen.dart';
import 'package:messenger/UI/MainPage/MainScreen.dart';
import 'package:messenger/UI/NewMessage/newMsgScreen.dart';
import 'package:messenger/UI/Search/searchScreen.dart';
import 'package:messenger/routes/router.dart';
import 'package:messenger/routes/router.gr.dart';

import 'BloC/Login/loginBloc.dart';
import 'MPref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MPref.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
            create: (BuildContext context) =>
                LoginBloc(LoginRepository(apiProvider: ApiProvider()))),
        BlocProvider<SearchBloc>(
            create: (BuildContext context) => SearchBloc()),
        BlocProvider<NewmessageBloc>(
            create: (BuildContext context) => NewmessageBloc()),
        BlocProvider<MessageListBloc>(
            create: (BuildContext context) =>
                MessageListBloc(MessageRepository(apiProvider: ApiProvider()))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('fa'), // farsi
        ],
        title: 'Flutter Demo',
        // initialRoute: Routes.loginScreen,
        builder: ExtendedNavigator.builder<Router>(router: Router()),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: '/login',
        // routes: {
        //   '/login': (context) => new Directionality(
        //       textDirection: TextDirection.rtl, child: LoginScreen()),
        //   '/search': (context) => new Directionality(
        //       textDirection: TextDirection.rtl, child: SearchScreen()),
        //   '/newMsg': (context) => new Directionality(
        //       textDirection: TextDirection.rtl, child: NewMsgScreen()),
        //   '/Main': (context) => new Directionality(
        //       textDirection: TextDirection.rtl, child: MainScreen()),
        // },
      ),
    );
  }
}
