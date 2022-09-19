import 'package:consequent_client/presentation/widgets/buttons/logout_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Hello World"),
          ),
          LogoutButton(),
        ],
      ),
    );
  }
}
