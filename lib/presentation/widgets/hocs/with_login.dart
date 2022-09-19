import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:consequent_client/presentation/widgets/texts/heading_1.dart';
import 'package:consequent_client/presentation/widgets/texts/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class WithLogin extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  final Widget child;
  WithLogin(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoggedIn() ? child : LoginWithMobile());
  }
}

class LoginWithMobile extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  LoginWithMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _controller.hasOTPBeenSent()
              ? _controller.verifyOTP
              : _controller.sendOTP,
          label: Text(
            _controller.hasOTPBeenSent() ? "Verify OTP" : "Next",
          ),
          icon: _controller.isLoading()
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                )
              : const Icon(
                  Icons.arrow_forward_sharp,
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(28, 50, 28, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeading(),
              getSubtitle(),
              getInput(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget getInput(BuildContext context) {
    if (_controller.hasOTPBeenSent()) {
      return getOTPInput(context);
    }
    return getMobileInput();
  }

  Widget getOTPInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OTPTextField(
          otpFieldStyle: OtpFieldStyle(
            borderColor: Theme.of(context).highlightColor,
            focusBorderColor: Theme.of(context).highlightColor,
            disabledBorderColor: Theme.of(context).highlightColor,
            enabledBorderColor: Theme.of(context).highlightColor,
            errorBorderColor: Colors.red,
          ),
          hasError: _controller.invalidOTPError().isNotEmpty,
          width: MediaQuery.of(context).size.width,
          length: 4,
          onChanged: _controller.onOTPChanged,
          fieldStyle: FieldStyle.box,
          fieldWidth: 40,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            letterSpacing: 5,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          _controller.invalidOTPError(),
          style: const TextStyle(
            color: Colors.red,
          ),
        )
      ],
    );
  }

  Expanded getMobileInput() {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: _controller.onMobileChanged,
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
              fontSize: 24,
            ),
          ),
          errorText: _controller.invalidMobileError(),
        ),
      ),
    );
  }

  Padding getSubtitle() {
    String text = _controller.hasOTPBeenSent()
        ? "We have sent an OTP to ${_controller.getEnteredMobileNumber()}"
        : "We will send you a confirmation code";

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Subtitle(
        text,
      ),
    );
  }

  Heading1 getHeading() {
    String text = _controller.hasOTPBeenSent()
        ? "Enter OTP sent to your number"
        : "Enter your mobile number";
    return Heading1(
      text,
    );
  }
}
