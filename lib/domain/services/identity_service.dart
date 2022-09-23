import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/identity_repo.dart';
import 'package:consequent_client/domain/services/exceptions.dart';
import 'package:consequent_client/domain/services/token_store.dart';

typedef LoginStateChangeCallback = void Function(bool isLoggedIn);

abstract class IdentityService {
  Future<bool> isLoggedIn();
  Future<String> sendOTP(int mobileNumber);
  Future<void> verifyOTP(String verificationID, int mobileNumber, int otp);
  Future<bool> isEmailRegistered(String email);
  Future<void> signUpWithEmail(
      String email, String password, String confirmPassword);
  Future<void> signInWithEmail(String email, String password);
  Future<void> logout();
  void onLoginStateChanged(LoginStateChangeCallback callback);
}

class IdentityServiceImpl implements IdentityService {
  final IdentityRepo repo;
  final TokenStore tokenStore;
  final List<LoginStateChangeCallback> _callbacks = [];

  IdentityServiceImpl({required this.repo, required this.tokenStore});

  @override
  Future<bool> isLoggedIn() async {
    try {
      Token? token = await tokenStore.getToken();
      if (token == null || token.refreshToken.token.isEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> sendOTP(int mobileNumber) {
    if (!_isMobileNumberValid(mobileNumber)) {
      throw InvalidMobileException();
    }

    return repo.sendOTP(mobileNumber);
  }

  bool _isMobileNumberValid(int mobileNumber) {
    return mobileNumber.toString().length ==
        10; // TODO (devesh2997) | improve this validation. (can use regex)
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    if (!_isEmailValid(email)) {
      throw InvalidEmailException();
    }
    if (!_isPasswordValid(password)) {
      throw InvalidPasswordException();
    }

    var token = await repo.signInWithEmail(email, password);
    await tokenStore.storeToken(token);

    notifyLoggedIn();
  }

  @override
  Future<void> verifyOTP(
      String verificationID, int mobileNumber, int otp) async {
    if (!_isOTPValid(otp)) {
      throw InvalidOTPException();
    }
    var token = await repo.verifyOTP(verificationID, mobileNumber, otp);
    await tokenStore.storeToken(token);

    notifyLoggedIn();
  }

  bool _isOTPValid(int otp) {
    return otp.toString().length == 4;
  }

  bool _isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length > 5;
  }

  @override
  Future<void> logout() async {
    await tokenStore.deleteToken();

    notifyLoggedOut();
  }

  @override
  void onLoginStateChanged(LoginStateChangeCallback callback) {
    _callbacks.add(callback);
  }

  void notifyLoggedIn() {
    for (var callback in _callbacks) {
      callback(true);
    }
  }

  void notifyLoggedOut() {
    for (var callback in _callbacks) {
      callback(false);
    }
  }

  @override
  Future<bool> isEmailRegistered(String email) async {
    if (!_isEmailValid(email)) {
      throw InvalidEmailException();
    }
    var registered = await repo.isEmailRegistered(email);

    return registered;
  }

  @override
  Future<void> signUpWithEmail(
      String email, String password, String confirmPassword) async {
    if (!_isEmailValid(email)) {
      throw InvalidEmailException();
    }
    if (!_isPasswordValid(password)) {
      throw InvalidPasswordException();
    }
    if (confirmPassword.compareTo(password) != 0) {
      throw ConfirmPasswordMismatchException();
    }

    var token = await repo.signInWithEmail(email, password);
    await tokenStore.storeToken(token);

    notifyLoggedIn();
  }
}
