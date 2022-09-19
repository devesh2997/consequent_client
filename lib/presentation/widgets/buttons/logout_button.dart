import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutButton extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _controller.logout,
      child: const Text(
        "Logout",
      ),
    );
  }
}
