import 'dart:developer';

import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class MobileInput extends StatefulWidget {
  MobileInput({Key? key}) : super(key: key);

  @override
  State<MobileInput> createState() => _MobileInputState();
}

class _MobileInputState extends State<MobileInput> {
  final IdentityController _controller = Get.find<IdentityController>();
  final _mobileInputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // _controller.onMobileChange((mobile) {
    //   _mobileInputController.text = mobile;
    // });

    // Start listening to changes.
    _mobileInputController.addListener(
      () {
        // _controller.setMobile(_mobileInputController.text);
        log(_mobileInputController.text);
      },
    );
  }

  @override
  void dispose() {
    _mobileInputController.dispose();
    super.dispose();
  }

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
                    controller: _controller.getMobileController(),
                    autofocus: true,
                    keyboardType: TextInputType.number,
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
