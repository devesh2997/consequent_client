import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class PasswordInput extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  PasswordInput({Key? key}) : super(key: key);

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
            child: TextField(
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              onChanged: _controller.setPassword,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              decoration: const InputDecoration.collapsed(hintText: ""),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _controller.invalidPasswordError(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
