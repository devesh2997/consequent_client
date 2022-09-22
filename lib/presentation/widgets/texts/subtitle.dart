import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final String text;
  final TextDecoration? decoration;
  final Color? textColor;
  const Subtitle(this.text, {Key? key, this.decoration, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        decoration: decoration,
        color: textColor,
      ),
    );
  }
}
