import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:consequent_client/presentation/widgets/appbars/default_app_bar.dart';
import 'package:consequent_client/presentation/widgets/texts/heading_1.dart';
import 'package:consequent_client/presentation/widgets/texts/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
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

class LoginWithMobile extends StatefulWidget {
  LoginWithMobile({Key? key}) : super(key: key);

  @override
  State<LoginWithMobile> createState() => _LoginWithMobileState();
}

class _LoginWithMobileState extends State<LoginWithMobile> {
  final IdentityController _controller = Get.find<IdentityController>();
  final OtpFieldController _otpController = OtpFieldController();

  _LoginWithMobileState() {
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
      () => _controller.hasOTPBeenSent()
          ? getOTPForm(context)
          : getMobileForm(context),
    );
  }

  Scaffold getMobileForm(BuildContext context) {
    var theme = NeumorphicTheme.of(context);

    return Scaffold(
      appBar: defaultAppBar(),
      floatingActionButton: NeumorphicFloatingActionButton(
          onPressed: _controller.sendOTP,
          child: _controller.isLoading()
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                )
              : Icon(
                  Icons.arrow_forward_sharp,
                  size: 24,
                  color:
                      theme?.isUsingDark ?? false ? Colors.white : Colors.black,
                )),
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
                getMobileInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Scaffold getOTPForm(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _controller.verifyOTP,
        label: const Text(
          "Verify OTP",
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
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading1("Enter OTP sent to your number"),
            getOTPInput(context),
            Subtitle(
              "We have sent an OTP to ${_controller.getEnteredMobileNumber()}.",
            ),
            const SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: _controller.changeMobileNumber,
              child: const Subtitle(
                "Not your number ? Change.",
                decoration: TextDecoration.underline,
                textColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getOTPInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        OTPTextField(
          controller: _otpController,
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
          onChanged: _controller.setOTP,
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

  Widget getMobileInput() {
    return TextField(
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
    );
  }
}
