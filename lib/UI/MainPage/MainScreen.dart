import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/BloC/Login/loginBloc.dart';
import 'package:messenger/BloC/MessageList/bloc/message_list_Bloc.dart';
import 'package:messenger/UI/NewMessage/newMsgScreen.dart';
import 'package:messenger/Widget/Btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  MessageListBloc messageListBloc;
  LoginBloc loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.loginBloc = BlocProvider.of<LoginBloc>(context);
    this.messageListBloc = BlocProvider.of<MessageListBloc>(context);
    messageListBloc.add(MessageListEvantRecive());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<MessageListBloc, MessageListState>(
          builder: (context, state) {
        /*if (state is SearchStateCompleted) {
          Future.delayed(const Duration(seconds: 3), () {
            //  Navigator.popAndPushNamed(context, '/main');
          });
        }
        if (state is SearchStateInitial || state is SearchStateInProgress) {
          return buildUiBasedSearchState(state);
        }*/
        return buildUiBasedMessageListState(state);
      }),
    );
  }

  Widget buildUiBasedMessageListState(State) {
    return Scaffold(
      appBar: AppBar(
        title: Text("صفحه اصلی ", style: TextStyle(fontSize: 13)),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: new IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, "/search");
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: new Column(
          children: <Widget>[
            // ignore: missing_required_param
            UserAccountsDrawerHeader(
              accountName: Text("زهرا موسوی"),
              currentAccountPicture: CircleAvatar(
                child: Text('Z'),
                //  backgroundImage: ,
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('پروفایل من'),
            ),
            ListTile(
              leading: Icon(Icons.move_to_inbox),
              title: Text('پیام ها'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('خروج'),
              onTap: () {
                exit(0);
                //this.loginBloc.add(new LoginEventLogOut());
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: new BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new ButtonText(icon: Icons.move_to_inbox, text: "دریافتی"),
              new FloatingActionButton(
                  child: Icon(Icons.add_comment_outlined),
                  backgroundColor: new Color(0xff333399),
                  onPressed: () {
                    Navigator.pushNamed(context, "/newMsg");
                  }),
              new ButtonText(icon: Icons.launch, text: "ارسالی"),
            ],
          ),
        ),
      ),
    );
  }
}
