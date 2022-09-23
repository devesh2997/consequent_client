import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:consequent_client/presentation/widgets/appbars/default_app_bar.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/mobile_input.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/submit.dart';
import 'package:consequent_client/presentation/widgets/texts/heading_1.dart';
import 'package:consequent_client/presentation/widgets/texts/subtitle.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class MobileForm extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  MobileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      floatingActionButton: LoginFlowSubmit(onPressed: _controller.sendOTP),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Neumorphic(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Heading1("Enter your mobile number"),
                const SizedBox(
                  height: 24,
                ),
                const Subtitle("We will send you a confirmation code"),
                const SizedBox(
                  height: 24,
                ),
                MobileInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
