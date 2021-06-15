import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hint;
  final String label;
  final bool obscure;
  final IconData icon;
  final double radius;
  final TextEditingController textController;
  //final IconData suffIcon;
  InputField(
      {this.hint,
      this.label,
      this.obscure,
      this.icon,
      this.textController,
      this.radius});
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: EdgeInsets.only(top: 0, right: 7, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: TextField(
        //validator: validator,
        obscureText: widget.obscure,
        controller: widget.textController,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,

            size: 15,
            // color: kPrimaryColor,
          ),
          hintText: widget.hint,
          labelText: widget.label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 11),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
