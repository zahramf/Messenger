import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("  ", style: TextStyle(fontSize: 13)),
      ),
      drawer: Drawer(
        child: new Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
