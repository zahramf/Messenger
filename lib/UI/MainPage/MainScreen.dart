import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/BloC/Login/loginBloc.dart';
import 'package:messenger/BloC/MessageList/bloc/message_list_Bloc.dart';
import 'package:messenger/Model/InboxModel.dart';
import 'package:messenger/UI/NewMessage/newMsgScreen.dart';
import 'package:messenger/Widget/Btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shamsi_date/shamsi_date.dart';
//import 'package:shamsi_date/extensions.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool selected = true;
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

  changeFlag(bool flag) {
    setState(() {
      selected = flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<MessageListBloc, MessageListState>(
          // ignore: missing_return
          builder: (context, state) {
        if (state is MessageListReciveStateComplete) {
          return buildUiBasedMessageListState(state);
        } else if (state is MessageListSendStateComplete) {
          return buildSentMessageList(state, context);
        } else if (state is MessageListSendStateInProgress ||
            state is MessageListReciveStateInProgress) {
          return CircularProgressIndicator();
        } else {
          Container();
        }
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
                //exit(0);
                this.loginBloc.add(new LoginEventLogOut());
              },
            ),
          ],
        ),
      ),
      body: buildReciveMessageList(State, context),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: new BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton.icon(
                  onPressed: () {
                    changeFlag(true);
                    buildReciveMessageList(State, context);
                  },
                  icon: Icon(Icons.move_to_inbox),
                  label: Text('ارسالی')),
              new FloatingActionButton(
                  child: Icon(Icons.add_comment_outlined),
                  backgroundColor: new Color(0xff333399),
                  onPressed: () {
                    Navigator.pushNamed(context, "/newMsg");
                  }),
              new FlatButton.icon(
                  onPressed: () {
                    changeFlag(false);
                    buildSentMessageList(State, context);
                  },
                  icon: Icon(Icons.launch),
                  label: Text('دریافتی')),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReciveMessageList(MessageListReciveStateComplete state, context) {
    return ListView.builder(
        itemCount: state.message.length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            child: new Container(
                margin: EdgeInsets.only(right: 8, left: 8, bottom: 1, top: 2),
                child: new Card(
                    child: new Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 10),
                  child:
                      new Stack(alignment: Alignment.bottomCenter, children: <
                          Widget>[
                    new Container(
                        alignment: Alignment.centerRight,
                        height: 60,
                        child: new Row(
                          children: <Widget>[
                            state.message[index].sender != null &&
                                    state.message[index].sender.pathCover
                                        .isNotEmpty
                                ? Image.network(
                                    state.message[index].sender.pathCover)
                                : Image.asset(
                                    'assets/images/default-avatar.png',
                                    fit: BoxFit.cover,
                                    height: 40,
                                    width: 40,
                                  ),
                            new Column(
                              children: <Widget>[
                                new Text(
                                  state.message[index].title.isNotEmpty
                                      ? state.message[index].title
                                      : "بدون عنوان",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: new Text(
                                    state.message[index].sender.fullname
                                            .isNotEmpty
                                        ? state.message[index].sender.fullname +
                                            state.message[index].sender.lastname
                                        : "ناشناس",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                                Expanded(
                                    child: Row(
                                  children: <Widget>[
                                    new Text(
                                      state.message[index].sender != null
                                          ? "${state.message[index].sender.deputy.title}| "
                                          : " ",
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    new Text(
                                      state.message[index].sender != null
                                          ? "${state.message[index].sender.part.title}| "
                                          : " ",
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    new Text(
                                      state.message[index].sender != null
                                          ? "${state.message[index].sender.post.title}"
                                          : " ",
                                      style: TextStyle(fontSize: 9),
                                    )
                                  ],
                                ))
                              ],
                            )
                          ],
                        )),
                    new Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: new Column(
                          children: <Widget>[
                            new Text(
                              format2(Jalali.fromDateTime(
                                      state.message[index].date)) +
                                  "\n" +
                                  state.message[index].date.hour.toString() +
                                  ":" +
                                  state.message[index].date.minute.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13),
                            ),
                            state.message[index].isSeen
                                ? new Icon(
                                    Icons.mark_email_read,
                                    color: Colors.green[800],
                                    size: 14,
                                  )
                                : new Icon(
                                    Icons.mail,
                                    color: Colors.red[600],
                                    size: 14,
                                  )
                            // new Icon(
                            // state.message[index].isSeen
                            //   ? Icons.mark_email_read
                            // : Icons.mail,
                            //size: 14,
                            // )
                          ],
                        )),
                  ]),
                ))),
          );
        });
  }

  Widget buildSentMessageList(MessageListSendStateComplete state, context) {
    return ListView.builder(
        itemCount: state.message.length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            child: new Container(
              margin: EdgeInsets.only(right: 8, left: 8, bottom: 2, top: 2),
              child: new Card(
                child: new Padding(
                    padding: const EdgeInsets.fromLTRB(5, 7, 5, 10),
                    child: new Row(
                      children: <Widget>[
                        state.message[index].receivers.first.user.pathCover !=
                                    null &&
                                state.message[index].receivers.first.user
                                    .pathCover.isNotEmpty
                            ? Image.network(state
                                .message[index].receivers.first.user.pathCover)
                            : Image.asset(
                                'assets/images/default-avatar.png',
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                              ),
                        new Column(
                          children: <Widget>[
                            new Text(
                              state.message[index].title.isNotEmpty
                                  ? state.message[index].title
                                  : "بدون عنوان",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: new Text(
                                state.message[index].receivers.first.user
                                        .fullname.isNotEmpty
                                    ? state.message[index].receivers.first.user
                                            .fullname +
                                        state.message[index].receivers.first
                                            .user.lastname
                                    : "ناشناس",
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          );
        });
  }

  String format2(Date d) {
    final f = d.formatter;

    return '${f.dd}/${f.mm}/${f.yyyy}';
  }
}
