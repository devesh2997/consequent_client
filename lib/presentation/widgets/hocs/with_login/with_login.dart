import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/email_form.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/mobile_form.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/otp_form.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/signin_form.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class WithLogin extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();
  final Widget child;
  WithLogin(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoggedIn() ? child : Login());
  }
}

class Login extends StatelessWidget {
  final IdentityController _controller = Get.find<IdentityController>();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isSignInWithMobileSelected()
          ? getMobileSignIn()
          : getEmailSignIn(),
    );
  }

  Widget getMobileSignIn() {
    return _controller.hasOTPBeenSent() ? OTPForm() : MobileForm();
  }

  Widget getEmailSignIn() {
    if (_controller.isEmailSubmitted()) {
      return _controller.isEmailRegistered() ? SignInForm() : SignUpForm();
    }

    return EmailForm();
  }
}
