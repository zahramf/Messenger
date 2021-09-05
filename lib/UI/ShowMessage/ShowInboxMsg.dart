import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:messenger/BloC/MessageList/bloc/message_list_Bloc.dart';
import 'package:messenger/routes/router.gr.dart';

// ignore: camel_case_types
class showInboxMsg extends StatefulWidget {
  final int msgId;
  //const showInboxMsg({this.msgId});

  const showInboxMsg({Key key, this.msgId}) : super(key: key);

  @override
  _showInboxMsgState createState() => _showInboxMsgState();
}

// ignore: camel_case_types
class _showInboxMsgState extends State<showInboxMsg> {
  MessageListBloc messageListBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.messageListBloc = BlocProvider.of<MessageListBloc>(context);
    messageListBloc
        .add(MessageListEventShowInboxMessage(messageId: widget.msgId));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("نمایش", style: TextStyle(fontSize: 13)),
          ),
          // ignore: missing_return
          body: BlocBuilder<MessageListBloc, MessageListState>(
              // ignore: missing_return
              builder: (context, state) {
            if (state is MessageListShowReciveStateMessage) {
              return showMessage(state);
            }
            if (state is MessageListReciveStateLoad) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          }),
          // ignore: missing_return
        ),
        // ignore: missing_return
        onWillPop: () {
          messageListBloc.add(MessageListEvantRecive(page: 1));
          ExtendedNavigator.of(context).push(Routes.mainScreen);
        });
  }

  Widget showMessage(MessageListShowReciveStateMessage state) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  state.showMessage.title.isNotEmpty
                      ? state.showMessage.title
                      : "بدون عنوان",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: new Text(
                    state.showMessage.sender != null
                        //.fullname.isNotEmpty
                        ? state.showMessage.sender.fullname.trim() +
                            " " +
                            state.showMessage.sender.lastname.trim()
                        : "ناشناس",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      state.showMessage.sender != null
                          ? "${state.showMessage.sender.deputy.title}| "
                          : " ",
                      style: TextStyle(fontSize: 9, color: Colors.blue[900]),
                    ),
                    Text(
                      state.showMessage.sender != null
                          ? "${state.showMessage.sender.part.title}| "
                          : " ",
                      style: TextStyle(fontSize: 9, color: Colors.blue[900]),
                    ),
                    Text(
                      state.showMessage.sender != null
                          ? "${state.showMessage.sender.post.title}"
                          : " ",
                      style: TextStyle(fontSize: 9, color: Colors.blue[900]),
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,

                  child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 2),
                      child: new Center(
                        child: SingleChildScrollView(
                          child: Html(
                            data: state.showMessage.text,
                            padding: EdgeInsets.all(2.0),
                          ),
                        ),
                      )
                      // Text(state.showMessage.text.replaceAll('<br />', '\n')),
                      ),
                  //Text(state.showMessage.text),
                  padding: EdgeInsets.fromLTRB(1, 10, 1, 20),
                  margin: EdgeInsets.fromLTRB(2, 10, 2, 15),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey[400])),
                ),
              ],
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // new Padding(
              // padding: const EdgeInsets.only(top: 50),
              //child:
              new ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * .25,
                  height: 40,
                  child: new RaisedButton(
                    onPressed: () {},
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          'پاسخ',
                          style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Icon(
                          Icons.replay,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    color: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )),
              //  ),
              // Padding(
              // padding: const EdgeInsets.only(top: 50),
              //child:
              new ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * .25,
                  height: 40,
                  child: new RaisedButton(
                    onPressed: () {},
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          'رونوشت',
                          style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Icon(
                          Icons.forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    color: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )),
              // )
            ],
          )
        ],
      ),
    );
  }
}
