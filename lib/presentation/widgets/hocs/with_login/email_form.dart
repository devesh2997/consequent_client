import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:consequent_client/presentation/widgets/appbars/default_app_bar.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/email_input.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/submit.dart';
import 'package:consequent_client/presentation/widgets/texts/heading_1.dart';
import 'package:consequent_client/presentation/widgets/texts/subtitle.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class EmailForm extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  EmailForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      floatingActionButton: LoginFlowSubmit(onPressed: _controller.submitEmail),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Neumorphic(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Heading1("Enter your email"),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 24,
                ),
                EmailInput(),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: _controller.toggleSignInMethod,
                  child: const Subtitle(
                    "Or Use Your Mobile Number.",
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
