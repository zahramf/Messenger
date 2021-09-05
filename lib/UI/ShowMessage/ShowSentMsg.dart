import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:messenger/BloC/MessageList/bloc/message_list_Bloc.dart';
import 'package:messenger/Model/Receiver.dart';
import 'package:messenger/routes/router.gr.dart';
import 'package:shamsi_date/shamsi_date.dart';

// ignore: camel_case_types
class showSentMsg extends StatefulWidget {
  final int msgId;
  //const showInboxMsg({this.msgId});

  const showSentMsg({Key key, this.msgId}) : super(key: key);

  @override
  _showSentMsgState createState() => _showSentMsgState();
}

// ignore: camel_case_types
class _showSentMsgState extends State<showSentMsg> {
  MessageListBloc messageListBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.messageListBloc = BlocProvider.of<MessageListBloc>(context);
    messageListBloc
        .add(MessageListEventShowSentMessage(messageId: widget.msgId));
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
            if (state is MessageListShowSentStateMessage) {
              return showSentMessage(state);
            }
            return Container(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          }),
        ),
        // ignore: missing_return
        onWillPop: () {
          messageListBloc.add(MessageListEvantRecive(page: 1));
          ExtendedNavigator.of(context).push(Routes.mainScreen);
        });
  }

  Widget showSentMessage(MessageListShowSentStateMessage state) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        state.showMessage.title.isNotEmpty
                            ? state.showMessage.title
                            : "بدون عنوان",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(2, 20, 2, 15),
                        child: new Text(
                          "ارسال شده به: " +
                              state.showMessage.receivers.length.toString() +
                              " نفر",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      //  Container(
                      //  height: 90,
                      //child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 5.0,
                              maxHeight:
                                  (state.showMessage.receivers.length == 1
                                      ? 30
                                      : 100.0),
                            ),
                            child: ListView.builder(
                                itemCount: state.showMessage.receivers.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: <Widget>[
                                      Icon(
                                        (state.showMessage.receivers[index]
                                                    .isSeen ==
                                                true
                                            ? Icons.drafts
                                            : Icons.email),
                                        color: state.showMessage
                                                .receivers[index].isSeen
                                            ? Colors.green
                                            : Colors.red,
                                        size: 14,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4),
                                        child: Text(
                                            getNameFromReciverList(state
                                                .showMessage.receivers[index]),
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blue[900])),
                                      )
                                    ],
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 1, 5, 8),
                            child: Text(
                              format1(Jalali.fromDateTime(
                                      state.showMessage.date)) +
                                  "   " +
                                  state.showMessage.date.hour.toString() +
                                  ":" +
                                  state.showMessage.date.minute.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      //),
                    ],
                  ),
                ),

                /////////////////Text
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Html(
                      data: state.showMessage.text,
                      padding: EdgeInsets.all(15.0),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey[400])),

                  /* child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: new Center(
                        child: SingleChildScrollView(
                          child: Html(
                            data: state.showMessage.text,
                            padding: EdgeInsets.all(8.0),
                          ),
                        ),
                      )
                      ),*/
                  //Text(state.showMessage.text),
                  // padding: EdgeInsets.fromLTRB(1, 1, 1, 20),
                  // margin: EdgeInsets.fromLTRB(2, 2, 2, 15),
                  //decoration: BoxDecoration(
                  // border: Border.all(width: 3, color: Colors.grey[400])),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  String getNameFromReciverList(Receivers reciver) {
    return reciver.user.fullname +
        " " +
        reciver.user.lastname +
        " (" +
        reciver.user.deputy.title +
        "|" +
        reciver.user.part.title +
        "|" +
        reciver.user.post.title +
        ")";
  }

  String format1(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy}';
  }
}
