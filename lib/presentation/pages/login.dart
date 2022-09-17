import 'package:consequent_client/presentation/widgets/buttons/rounded_button.dart';
import 'package:consequent_client/presentation/widgets/texts/heading_1.dart';
import 'package:consequent_client/presentation/widgets/texts/subtitle.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Transform.rotate(
                  angle: 180 * math.pi / 180,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_right_alt,
                      )),
                )
              ],
            ),
            const Heading1(
              "Enter your mobile number",
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Subtitle(
                "We will send you a confirmation code",
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text(
                  "+91",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      letterSpacing: 5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedButton(
              isExtended: true,
              onPressed: () {},
              ctaText: "Next",
            ),
          ],
        ),
      ),
    );
  }
}
