import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final IconData icon;
  final String text;

  ButtonText({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        //  onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: new Color(0xff333399),
                    ),
                    Text(
                      text,
                      style:
                          TextStyle(fontSize: 12, color: new Color(0xff333399)),
                    ),
                  ],
                ),
              ],
            )));
  }
}
