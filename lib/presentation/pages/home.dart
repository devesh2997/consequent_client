import 'package:consequent_client/presentation/widgets/appbars/default_app_bar.dart';
import 'package:consequent_client/presentation/widgets/buttons/logout_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Hello World"),
          ),
          LogoutButton(),
        ],
      ),
    );
  }
}
