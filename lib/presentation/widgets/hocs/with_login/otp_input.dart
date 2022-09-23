import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OTPInput extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  final OtpFieldController _otpController = OtpFieldController();

  OTPInput({Key? key}) : super(key: key) {
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
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Neumorphic(
            style: const NeumorphicStyle(),
            padding: const EdgeInsets.all(16),
            child: OTPTextField(
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
      ),
    );
  }
}
