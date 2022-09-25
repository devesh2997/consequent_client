import 'package:consequent_client/containers/identity_container.dart';
import 'package:consequent_client/domain/services/exceptions.dart';
import 'package:consequent_client/domain/services/identity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'dart:async';

typedef OTPChangeCallback = void Function(int otp);
typedef MobileChangeCallback = void Function(String mobile);

class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 10),
      () => 'Your code is 54321',
    );
  }
}

class IdentityController extends GetxController {
  final IdentityService identityService = injectIdentityService();

  // loading states
  final Rx<bool> _isLoggedIn = false.obs;
  final Rx<bool> _isSendingOTP = false.obs;
  final Rx<bool> _isVerifyingOTP = false.obs;
  final Rx<bool> _isSubmittingEmail = false.obs;
  final Rx<bool> _isSigningUp = false.obs;
  final Rx<bool> _isSigningIn = false.obs;

  // process states
  final Rx<bool> _signInWithMobileSelected = true.obs;
  final Rx<bool> _otpSent = false.obs;
  final Rx<bool> _emailSubmitted = false.obs;
  final Rx<bool> _isEmailRegistered = false.obs;
  final Rx<int> _resendOTPTimeout = 10.obs;

  // input states
  final Rx<String> _email = "".obs;
  final Rx<String> _password = "".obs;
  final Rx<String> _confirmPassword = "".obs;
  final Rx<int> _mobileNumber = 0.obs;
  int _otp = 0;
  String _verificationID = "";

  // error states
  final Rx<String> _error = "".obs;
  final Rx<String> _invalidMobileError = "".obs;
  final Rx<String> _invalidOTPError = "".obs;
  final Rx<String> _invalidEmailError = "".obs;
  final Rx<String> _invalidPasswordError = "".obs;
  final Rx<String> _invalidConfirmPasswordError = "".obs;

  // input controllers
  late OTPTextEditController controller;
  final _mobileInputController = TextEditingController();

  // callbacks
  OTPChangeCallback? _otpChangeCallback;

  @override
  void onInit() async {
    try {
      var res = await identityService.isLoggedIn();
      _isLoggedIn.value = res;

      identityService.onLoginStateChanged((loggedIn) {
        _isLoggedIn.value = loggedIn;
        if (loggedIn) {
          _reset();
        }
      });

      _mobileInputController.addListener(() {
        _setMobile(_mobileInputController.text);
      });
    } catch (e) {}
    super.onInit();
  }

  _resetResendOTPTimeout() {
    _resendOTPTimeout.value = 15;
    _beginResendOTPTimer();
  }

  _beginResendOTPTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _resendOTPTimeout.value = _resendOTPTimeout.value - 1;
      if (_resendOTPTimeout.value == 0) {
        timer.cancel();
      }
    });
  }

  TextEditingController getMobileController() {
    return _mobileInputController;
  }

  void toggleSignInMethod() {
    _signInWithMobileSelected.value = !_signInWithMobileSelected.value;
  }

  void onOTPChanged(OTPChangeCallback callback) {
    _otpChangeCallback = callback;
  }

  void _setMobile(String mobileNumber) {
    _resetErrors();
    if (mobileNumber.length > 10) {
      mobileNumber = mobileNumber.substring(0, 10);
    }
    var mobile = int.tryParse(mobileNumber) ?? 0;
    mobileNumber = mobile == 0 ? "" : mobile.toString();

    _mobileInputController.value = TextEditingValue(
      text: mobileNumber,
      selection: TextSelection.fromPosition(
        TextPosition(offset: mobileNumber.length),
      ),
    );
    _mobileNumber.value = mobile;
  }

  void setEmail(String email) {
    _resetErrors();
    _email.value = email;
  }

  void setPassword(String password) {
    _resetErrors();
    _password.value = password;
  }

  void setConfirmPassword(String confirmPassword) {
    _resetErrors();
    _confirmPassword.value = confirmPassword;
  }

  void setOTP(String otp) {
    _invalidOTPError.value = "";
    _otp = int.tryParse(otp) ?? 0;
    if (otp.length == 4) {
      verifyOTP();
    }
  }

  void changeEmail() {
    _resetErrors();
    _resetInputs();
    _resetLoaders();
    _resetStates();
  }

  void changeMobileNumber() {
    _resetErrors();
    _resetOTPInputs();
    _resetLoaders();
    _resetStates();
  }

  void _reset() {
    _resetErrors();
    _resetInputs();
    _resetLoaders();
    _resetStates();
  }

  void _resetErrors() {
    _invalidMobileError.value = "";
    _error.value = "";
    _invalidOTPError.value = "";
    _invalidEmailError.value = "";
    _invalidPasswordError.value = "";
    _invalidConfirmPasswordError.value = "";
  }

  void _resetLoaders() {
    _isSendingOTP.value = false;
    _isVerifyingOTP.value = false;
    _isSubmittingEmail.value = false;
    _isSigningIn.value = false;
    _isSigningUp.value = false;
  }

  void _resetInputs() {
    _resetOTPInputs();
    _mobileNumber.value = 0;
    _email.value = "";
    _password.value = "";
    _confirmPassword.value = "";
  }

  void _resetOTPInputs() {
    _verificationID = "";
    _otp = 0;
  }

  void _resetStates() {
    _otpSent.value = false;
    _emailSubmitted.value = false;
  }

  void _startListeningForOTP() {
    controller = OTPTextEditController(
      codeLength: 4,
      onCodeReceive: (code) {
        _otpChangeCallback!(int.tryParse(code) ?? 0);
      },
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{4})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [
          // SampleStrategy(),
        ],
      );
  }

  void submitEmail() async {
    _isSubmittingEmail.value = true;
    try {
      var registered = await identityService.isEmailRegistered(_email.value);
      _isEmailRegistered.value = registered;
      _emailSubmitted.value = true;
    } on InvalidEmailException catch (e) {
      _invalidEmailError.value = e.toString();
    } catch (e) {
      _invalidEmailError.value = e.toString();
    }
    _isSubmittingEmail.value = false;
  }

  void signUPWithEmail() async {
    _isSigningUp.value = true;

    try {
      await identityService.signUpWithEmail(
          _email.value, _password.value, _confirmPassword.value);
    } on InvalidEmailException catch (e) {
      _invalidEmailError.value = e.toString();
    } on InvalidPasswordException catch (e) {
      _invalidPasswordError.value = e.toString();
    } on ConfirmPasswordMismatchException catch (e) {
      _invalidConfirmPasswordError.value = e.toString();
    } catch (e) {
      _invalidPasswordError.value = e.toString();
    }

    _isSigningUp.value = false;
  }

  void signInWithEmail() async {
    _isSigningIn.value = true;

    try {
      await identityService.signInWithEmail(_email.value, _password.value);
    } on InvalidEmailException catch (e) {
      _invalidEmailError.value = e.toString();
    } on InvalidPasswordException catch (e) {
      _invalidPasswordError.value = e.toString();
    } on ConfirmPasswordMismatchException catch (e) {
      _invalidConfirmPasswordError.value = e.toString();
    } catch (e) {
      _invalidPasswordError.value = e.toString();
    }

    _isSigningIn.value = false;
  }

  void sendOTP() async {
    _isSendingOTP.value = true;
    _resetErrors();
    try {
      var verificationID = await identityService.sendOTP(_mobileNumber.value);
      _verificationID = verificationID;
      _otpSent.value = true;
      _resetResendOTPTimeout();
      _startListeningForOTP();
    } on InvalidMobileException catch (e) {
      _invalidMobileError.value = e.toString();
    } catch (e) {
      _invalidMobileError.value = e.toString();
    }

    _isSendingOTP.value = false;
  }

  void resendOTP() async {
    if (!canResendOTP()) {
      return;
    }
    _isSendingOTP.value = true;
    _resetErrors();
    try {
      var verificationID = await identityService.resendOTP(_verificationID);
      _verificationID = verificationID;
      _otpSent.value = true;
      _resetResendOTPTimeout();
      _startListeningForOTP();
    } on InvalidMobileException catch (e) {
      _invalidMobileError.value = e.toString();
    } catch (e) {
      _invalidMobileError.value = e.toString();
    }

    _isSendingOTP.value = false;
  }

  void verifyOTP() async {
    _isVerifyingOTP.value = true;
    _resetErrors();
    try {
      await identityService.verifyOTP(
          _verificationID, _mobileNumber.value, _otp);
    } on InvalidOTPException catch (e) {
      _invalidOTPError.value = e.toString();
    } catch (e) {
      _invalidOTPError.value = e.toString();
    }

    _isVerifyingOTP.value = false;
  }

  bool hasOTPBeenSent() {
    return _otpSent.value;
  }

  String invalidMobileError() {
    return _invalidMobileError.value;
  }

  String invalidEmailError() {
    return _invalidEmailError.value;
  }

  String invalidPasswordError() {
    return _invalidPasswordError.value;
  }

  String invalidConfirmPasswordError() {
    return _invalidConfirmPasswordError.value;
  }

  String invalidOTPError() {
    return _invalidOTPError.value;
  }

  bool isSendingOTP() {
    return _isSendingOTP.value;
  }

  bool isVerifyingOTP() {
    return _isVerifyingOTP.value;
  }

  bool isSubmittingEmail() {
    return _isSubmittingEmail.value;
  }

  bool isSigningUp() {
    return _isSigningUp.value;
  }

  bool isSigningIn() {
    return _isSigningIn.value;
  }

  bool isLoading() {
    return isSendingOTP() ||
        isVerifyingOTP() ||
        isSubmittingEmail() ||
        isSigningIn() ||
        isSigningUp();
  }

  int getEnteredMobileNumber() {
    return _mobileNumber.value;
  }

  String getEnteredEmail() {
    return _email.value;
  }

  bool isLoggedIn() {
    return _isLoggedIn.value;
  }

  bool isEmailSubmitted() {
    return _emailSubmitted.value;
  }

  bool isEmailRegistered() {
    return _isEmailRegistered.value;
  }

  bool isSignInWithMobileSelected() {
    return _signInWithMobileSelected.value;
  }

  int getResendOTPTimeout() {
    return _resendOTPTimeout.value;
  }

  bool canResendOTP() {
    return getResendOTPTimeout() == 0;
  }

  void logout() {
    identityService.logout();
  }
}
