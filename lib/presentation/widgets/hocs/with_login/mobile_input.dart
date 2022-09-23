import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class MobileInput extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  MobileInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        keyboardType: TextInputType.number,
        onChanged: _controller.setMobile,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          letterSpacing: 5,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          icon: const Text(
            "+91",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          errorText: _controller.invalidMobileError(),
        ),
      ),
    );
  }
}
