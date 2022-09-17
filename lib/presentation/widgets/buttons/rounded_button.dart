import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final void Function() onPressed;
  final String ctaText;
  bool? isExtended;

  RoundedButton({
    Key? key,
    required this.onPressed,
    required this.ctaText,
    this.isExtended = false,
  }) : super(key: key);

  ButtonStyle getButtonStyle() {
    MaterialStateProperty<OutlinedBorder?> buttonShape =
        MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
    );
    ButtonStyle bs;

    if (isExtended ?? false) {
      bs = ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(50)),
        shape: buttonShape,
      );
    } else {
      bs = ButtonStyle(
        shape: buttonShape,
      );
    }

    return bs;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: getButtonStyle(),
      onPressed: onPressed,
      child: Text(
        ctaText,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
