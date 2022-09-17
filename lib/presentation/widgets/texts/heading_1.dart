import 'package:flutter/material.dart';

class Heading1 extends StatelessWidget {
  final String text;
  const Heading1(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
