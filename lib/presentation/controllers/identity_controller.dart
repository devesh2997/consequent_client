import 'package:consequent_client/containers/identity_container.dart';
import 'package:consequent_client/domain/services/exceptions.dart';
import 'package:consequent_client/domain/services/identity_service.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';

typedef OTPChangeCallback = void Function(int otp);

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

  final Rx<bool> _isLoggedIn = false.obs;
  final Rx<bool> _isSendingOTP = false.obs;
  final Rx<bool> _otpSent = false.obs;
  final Rx<bool> _isVerifyingOTP = false.obs;

  final Rx<int> _mobileNumber = 0.obs;
  int _otp = 0;
  String _verificationID = "";

  final Rx<String> _error = "".obs;

  final Rx<String> _invalidMobileError = "".obs;
  final Rx<String> _invalidOTPError = "".obs;

  late OTPTextEditController controller;

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
      _startListeningForOTP();
    } catch (e) {}
    super.onInit();
  }

  void onOTPChanged(OTPChangeCallback callback) {
    _otpChangeCallback = callback;
  }

  void setMobile(String mobileNumber) {
    _resetErrors();
    _mobileNumber.value = int.tryParse(mobileNumber) ?? 0;
  }

  void setOTP(String otp) {
    _invalidOTPError.value = "";
    _otp = int.tryParse(otp) ?? 0;
    if (otp.length == 4) {
      verifyOTP();
    }
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
  }

  void _resetLoaders() {
    _isSendingOTP.value = false;
    _isVerifyingOTP.value = false;
  }

  void _resetInputs() {
    _resetOTPInputs();
    _mobileNumber.value = 0;
  }

  void _resetOTPInputs() {
    _verificationID = "";
    _otp = 0;
  }

  void _resetStates() {
    _otpSent.value = false;
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

  void sendOTP() async {
    _isSendingOTP.value = true;
    _resetErrors();
    try {
      var verificationID = await identityService.sendOTP(_mobileNumber.value);
      _verificationID = verificationID;
      _otpSent.value = true;
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

  String invalidOTPError() {
    return _invalidOTPError.value;
  }

  bool isSendingOTP() {
    return _isSendingOTP.value;
  }

  bool isVerifyingOTP() {
    return _isVerifyingOTP.value;
  }

  bool isLoading() {
    return isSendingOTP() || isVerifyingOTP();
  }

  int getEnteredMobileNumber() {
    return _mobileNumber.value;
  }

  bool isLoggedIn() {
    return _isLoggedIn.value;
  }

  void logout() {
    identityService.logout();
  }
}
