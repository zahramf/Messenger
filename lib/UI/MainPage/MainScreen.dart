import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/BloC/Login/loginBloc.dart';
import 'package:messenger/BloC/MessageList/bloc/message_list_Bloc.dart';
import 'package:messenger/Model/InboxModel.dart';
import 'package:messenger/Model/SentModel.dart';
import 'package:messenger/UI/ShowMessage/ShowInboxMsg.dart';

import 'package:messenger/routes/router.gr.dart';
import 'package:shamsi_date/shamsi_date.dart';
//import 'package:shamsi_date/extensions.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool selected = true;
  bool isLoading = false;
  int inboxPage = 1;
  int sendPage = 1;
  MessageListBloc messageListBloc;
  LoginBloc loginBloc;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.loginBloc = BlocProvider.of<LoginBloc>(context);
    this.messageListBloc = BlocProvider.of<MessageListBloc>(context);

    messageListBloc.add(MessageListEvantRecive(page: this.inboxPage));
    messageListBloc.add(MessageListEventaSend(page: this.sendPage));

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;

      if (maxScroll == currentScroll) {
        if (selected) {
          this.inboxPage += 1;
          messageListBloc.add(MessageListEvantRecive(page: this.inboxPage));
        } else {
          this.sendPage += 1;
          messageListBloc.add(MessageListEventaSend(page: this.sendPage));
        }
      }
    });
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
      appBar: AppBar(
        title: Text("صفحه اصلی ", style: TextStyle(fontSize: 13)),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: new IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                ExtendedNavigator.of(context).push(Routes.searchScreen);
                // Navigator.pushNamed(context, "/search");
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
      body: BlocBuilder<MessageListBloc, MessageListState>(
          // ignore: missing_return
          builder: (context, state) {
        if (state is MessageListStateInitial) {
          Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MessageListReciveStateLoad) {
          if (state.maxItemNum == true) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Row(
                children: <Widget>[
                  Icon(Icons.dangerous),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text("پیامی برای نمایش وجود ندارد"))
                ],
              )));
            });
          }
          // return buildReciveMessageList(state, context);
          return buildUiBasedMessageListState(state);
        } else if (state is MessageListSendStateLoad) {
          return buildSentMessageList(state, context);
        } else if (state is MessageListSendStateInProgress ||
            state is MessageListReciveStateInProgress) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        } else if (state is MessageListStateErrore) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Row(
              children: <Widget>[
                Icon(Icons.error),
                SizedBox(
                  width: 15,
                ),
                Expanded(child: Text("خطا در برقراری ارتباط با سرور"))
              ],
            )));
          });
        } else if (state is MessageListEventShowInboxMessage) {
          Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
            child: Center(
          child: CircularProgressIndicator(),
        ));
      }),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: new BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton.icon(
                  onPressed: () {
                    changeFlag(true);
                    //buildReciveMessageList(State, context);
                    messageListBloc
                        .add(MessageListEvantRecive(page: inboxPage));
                  },
                  icon: Icon(Icons.move_to_inbox),
                  label: Text('دریافتی')),
              new FloatingActionButton(
                  child: Icon(Icons.add_comment_outlined),
                  backgroundColor: new Color(0xff333399),
                  onPressed: () {
                    ExtendedNavigator.of(context).push(Routes.newMsgScreen);
                    //Navigator.pushNamed(context, "/newMsg");
                  }),
              new FlatButton.icon(
                  onPressed: () {
                    // print("press");
                    changeFlag(false);
                    // buildSentMessageList(State, context);
                    messageListBloc.add(MessageListEventaSend(page: sendPage));
                  },
                  icon: Icon(Icons.launch),
                  label: Text('ارسالی')),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUiBasedMessageListState(State) {
    return Scaffold(
      body: buildReciveMessageList(State, context),
    );
  }

  Widget buildReciveMessageList(MessageListReciveStateLoad state, context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: state.message.length,
        itemBuilder: (context, index) {
          InboxModel idMsg = state.message[index];
          return new GestureDetector(
            onTap: () {
              print("Item Click");
              print(idMsg.mailId);

              ExtendedNavigator.of(context).push(Routes.showInboxMsg,
                  arguments: showInboxMsgArguments(msgId: idMsg.mailId));
            },
            child: new Container(
                margin: EdgeInsets.only(right: 8, left: 8, bottom: 1, top: 2),
                child: new Card(
                    child: new Padding(
                        padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                state.message[index].sender != null &&
                                        state.message[index].sender.pathCover
                                            .isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          state.message[index].sender.pathCover,
                                          height: 50,
                                          width: 50,
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/images/default-avatar.png',
                                        fit: BoxFit.cover,
                                        height: 40,
                                        width: 40,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        padding:
                                            const EdgeInsets.only(right: 2),
                                        child: new Text(
                                          state.message[index].sender != null
                                              //.fullname.isNotEmpty
                                              ? state.message[index].sender
                                                      .fullname
                                                      .trim() +
                                                  " " +
                                                  state.message[index].sender
                                                      .lastname
                                                      .trim()
                                              : "ناشناس",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            state.message[index].sender != null
                                                ? "${state.message[index].sender.deputy.title}| "
                                                : " ",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.blue[900]),
                                          ),
                                          Text(
                                            state.message[index].sender != null
                                                ? "${state.message[index].sender.part.title}| "
                                                : " ",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.blue[900]),
                                          ),
                                          Text(
                                            state.message[index].sender != null
                                                ? "${state.message[index].sender.post.title}"
                                                : " ",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.blue[900]),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    format1(Jalali.fromDateTime(
                                            state.message[index].date)) +
                                        "\n" +
                                        state.message[index].date.hour
                                            .toString() +
                                        ":" +
                                        state.message[index].date.minute
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 180, bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        state.message[index].isSeen
                                            ? new Icon(
                                                Icons.check,
                                                color: Colors.green[800],
                                                size: 14,
                                              )
                                            : new Icon(
                                                Icons.check,
                                                color: Colors.red[600],
                                                size: 14,
                                              )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )))),
          );
        });
  }

  Widget buildSentMessageList(MessageListSendStateLoad state, context) {
    return ListView.builder(
        itemCount: state.message.length,
        itemBuilder: (context, index) {
          SentModel idMsg = state.message[index];
          return new GestureDetector(
            onTap: () {
              print("Item Click");
              print(idMsg.mailId);

              ExtendedNavigator.of(context).push(Routes.showSentMsg,
                  arguments: showSentMsgArguments(msgId: idMsg.mailId));
            },
            child: new Container(
                margin: EdgeInsets.only(right: 8, left: 8, bottom: 1, top: 2),
                child: new Card(
                    child: new Padding(
                        padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                state.message[index].receivers.first.user
                                                .pathCover !=
                                            null &&
                                        state.message[index].receivers.first
                                            .user.pathCover.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          state.message[index].receivers.first
                                              .user.pathCover,
                                          height: 50,
                                          width: 50,
                                        ))
                                    : Image.asset(
                                        'assets/images/default-avatar.png',
                                        fit: BoxFit.cover,
                                        height: 40,
                                        width: 40,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        state.message[index].title.isNotEmpty
                                            ? state.message[index].title
                                            : "بدون عنوان",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      new Padding(
                                        padding:
                                            const EdgeInsets.only(right: 2),
                                        child: Text(
                                          state.message[index].receivers.first
                                                  .user.fullname.isNotEmpty
                                              ? state.message[index].receivers
                                                      .first.user.fullname +
                                                  " " +
                                                  state.message[index].receivers
                                                      .first.user.lastname
                                              : "ناشناس",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: Text(
                                    format1(Jalali.fromDateTime(
                                            state.message[index].date)) +
                                        "  " +
                                        state.message[index].date.hour
                                            .toString() +
                                        ":" +
                                        state.message[index].date.minute
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 170, bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      state.message[index].receivers.first
                                              .isSeen
                                          ? new Icon(
                                              Icons.check,
                                              color: Colors.green[800],
                                              size: 14,
                                            )
                                          : new Icon(
                                              Icons.check,
                                              color: Colors.red[600],
                                              size: 14,
                                            )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )))),
          );
        });
  }

  String format1(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy}';
  }
}
