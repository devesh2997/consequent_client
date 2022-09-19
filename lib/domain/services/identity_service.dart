import 'package:consequent_client/domain/repositories/identity_repo.dart';
import 'package:consequent_client/domain/services/exceptions.dart';
import 'package:consequent_client/domain/services/token_store.dart';

typedef LoginStateChangeCallback = void Function(bool isLoggedIn);

abstract class IdentityService {
  Future<bool> isLoggedIn();
  Future<String> sendOTP(int mobileNumber);
  Future<void> verifyOTP(String verificationID, int mobileNumber, int otp);
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
      String? refreshToken = await tokenStore.getRefreshToken();
      if (refreshToken == null) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> sendOTP(int mobileNumber) {
    if (!_validateMobileNumber(mobileNumber)) {
      throw InvalidMobileException();
    }

    return repo.sendOTP(mobileNumber);
  }

  bool _validateMobileNumber(int mobileNumber) {
    return mobileNumber.toString().length !=
        10; // TODO (devesh2997) | improve this validation. (can use regex)
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    if (!_validateEmail(email)) {
      throw InvalidEmailException();
    }

    var token = await repo.signInWithEmail(email, password);
    await tokenStore.storeToken(token);

    notifyLoggedIn();
  }

  @override
  Future<void> verifyOTP(
      String verificationID, int mobileNumber, int otp) async {
    var token = await repo.verifyOTP(verificationID, mobileNumber, otp);
    await tokenStore.storeToken(token);

    notifyLoggedIn();
  }

  bool _validateEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
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
      callback(true);
    }
  }
}
