import 'package:flutter/material.dart';

class Heading3 extends StatelessWidget {
  final String text;
  const Heading3(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
