import 'package:flutter/material.dart';

class ExtendedButton extends StatelessWidget {
  final void Function() onPressed;
  final String ctaText;

  const ExtendedButton(
      {Key? key, required this.onPressed, required this.ctaText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: onPressed,
      child: Text(
        ctaText,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
