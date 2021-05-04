import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/BloC/MessageList/bloc/message_list_Bloc.dart';
import 'package:messenger/BloC/NewMessage/bloc/new_messageBloc.dart';
import 'package:messenger/BloC/Search/searchBloc.dart';
import 'package:messenger/UI/Login/loginScreen.dart';
import 'package:messenger/UI/MainPage/MainScreen.dart';
import 'package:messenger/UI/NewMessage/newMsgScreen.dart';
import 'package:messenger/UI/Search/searchScreen.dart';

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
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<SearchBloc>(
            create: (BuildContext context) => SearchBloc()),
        BlocProvider<NewmessageBloc>(
            create: (BuildContext context) => NewmessageBloc()),
        BlocProvider<MessageListBloc>(
            create: (BuildContext context) => MessageListBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => new Directionality(
              textDirection: TextDirection.rtl, child: LoginScreen()),
          '/search': (context) => new Directionality(
              textDirection: TextDirection.rtl, child: SearchScreen()),
          '/newMsg': (context) => new Directionality(
              textDirection: TextDirection.rtl, child: NewMsgScreen()),
          '/Main': (context) => new Directionality(
              textDirection: TextDirection.rtl, child: MainScreen()),
        },
      ),
    );
  }
}
