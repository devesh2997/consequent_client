import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class LoginFlowSubmit extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  final void Function() onPressed;
  LoginFlowSubmit({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context);

    return Obx(() => NeumorphicFloatingActionButton(
          onPressed: onPressed,
          child: _controller.isLoading()
              ? const NeumorphicProgressIndeterminate(
                  height: 4,
                )
              : Icon(
                  Icons.arrow_forward_sharp,
                  size: 24,
                  color:
                      theme?.isUsingDark ?? false ? Colors.white : Colors.black,
                ),
        ));
  }
}
