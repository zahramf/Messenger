import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.messageListBloc = BlocProvider.of<MessageListBloc>(context);
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
//        : Icon(Icons.search),
        title: Text("صفحه اصلی ", style: TextStyle(fontSize: 13)),
        // leading: new Icon(Icons.dehaze),
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
      /* body: new Row(
        children: <Widget>[
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.text_rotation_angleup,
              color: new Color(0xff333399),
              // color: Colors.amber[700],
            ),
            label: Text("خوانده",
                style: TextStyle(fontSize: 13, color: Colors.black)),
            //  shape: Border.all(color: Colors.grey),
          ),
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.sort,
                color: new Color(0xff333399),
                // color: Colors.amber[700],
              ),
              label: Text("مرتب سازی",
                  style: TextStyle(fontSize: 13, color: Colors.black))),
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: new Color(0xff333399),
                // color: Colors.amber[700],
              ),
              label: Text("جستجو",
                  style: TextStyle(fontSize: 13, color: Colors.black))),
        ],
      ),*/
    );
  }
}
