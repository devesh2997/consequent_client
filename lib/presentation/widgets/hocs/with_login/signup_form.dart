import 'package:consequent_client/presentation/widgets/hocs/with_login/config_password_input.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/password_input.dart';
import 'package:consequent_client/presentation/widgets/texts/heading_3.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:consequent_client/presentation/widgets/appbars/default_app_bar.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/email_input.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/mobile_input.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/submit.dart';
import 'package:consequent_client/presentation/widgets/texts/heading_1.dart';
import 'package:consequent_client/presentation/widgets/texts/subtitle.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();

  SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      floatingActionButton:
          LoginFlowSubmit(onPressed: _controller.signUPWithEmail),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Neumorphic(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Heading1("Let's get you setup !"),
                const SizedBox(
                  height: 12,
                ),
                const Heading3("Enter your password"),
                const SizedBox(
                  height: 8,
                ),
                PasswordInput(),
                const Heading3("Confirm your password"),
                const SizedBox(
                  height: 8,
                ),
                ConfirmPasswordInput(),
                const SizedBox(
                  height: 8,
                ),
                Subtitle(
                  "Creating account for ${_controller.getEnteredEmail()}.",
                ),
                const SizedBox(
                  height: 6,
                ),
                GestureDetector(
                  onTap: _controller.changeEmail,
                  child: const Subtitle(
                    "Not your email ? Change.",
                    decoration: TextDecoration.underline,
                    textColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
