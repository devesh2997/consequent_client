import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:consequent_client/presentation/widgets/appbars/default_app_bar.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/otp_input.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/submit.dart';
import 'package:consequent_client/presentation/widgets/texts/heading_1.dart';
import 'package:consequent_client/presentation/widgets/texts/subtitle.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class OTPForm extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  final OtpFieldController _otpController = OtpFieldController();

  OTPForm({Key? key}) : super(key: key) {
    _controller.onOTPChanged((otp) {
      var otpStr = otp.toString();
      var i = 0;
      otpStr.runes.forEach((rune) {
        var character = String.fromCharCode(rune);
        _otpController.setValue(character, i);
        i++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: defaultAppBar(),
        floatingActionButton: LoginFlowSubmit(onPressed: _controller.verifyOTP),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Neumorphic(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Heading1("Enter OTP sent to your number"),
                  OTPInput(),
                  Subtitle(
                    "We have sent an OTP to ${_controller.getEnteredMobileNumber()}.",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: _controller.changeMobileNumber,
                    child: const Subtitle(
                      "Not your number ? Change.",
                      decoration: TextDecoration.underline,
                      textColor: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  resendOTP(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector resendOTP() {
    var textColor = Colors.blue;
    var text = "Didn't receive OTP ? Resend";
    if (_controller.canResendOTP()) {
      text += ".";
    } else {
      textColor = Colors.grey;
      text += " in ${_controller.getResendOTPTimeout()} seconds.";
    }

    return GestureDetector(
      onTap: _controller.resendOTP,
      child: Subtitle(
        text,
        decoration: TextDecoration.underline,
        textColor: textColor,
      ),
    );
  }
}
