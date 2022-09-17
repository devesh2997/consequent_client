import 'package:consequent_client/presentation/widgets/buttons/extended_button.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                "Consequent",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ExtendedButton(
              ctaText: "GET STARTED",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
