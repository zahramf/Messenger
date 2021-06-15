import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/MPref.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  startTime() {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  navigationPage() {
    final accessToken = MPref.getString('AccessToken');
    if (accessToken != null && accessToken.length > 0) {
      Navigator.of(context).pushReplacementNamed('/main-screen');
    } else {
      Navigator.of(context).pushReplacementNamed('/login-screen');
    }
  }

  @override
  void initState() {
    // TODO: implement build
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 125,
                  height: 125,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image:
                              new AssetImage('assets/images/message128.png'))),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: new Text(
                    ' پیام رسان',
                    style: new TextStyle(
                        fontSize: 30,
                        color: Colors.blue[300],
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: new Align(
                alignment: Alignment.bottomCenter,
                child: new CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
