import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final String text;
  const Subtitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
