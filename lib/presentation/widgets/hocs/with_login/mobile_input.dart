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
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Neumorphic(
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.stadium(),
              depth: -2,
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              children: [
                const Text(
                  "+91",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    onChanged: _controller.setMobile,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                    decoration: const InputDecoration.collapsed(hintText: ""),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _controller.invalidMobileError(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
