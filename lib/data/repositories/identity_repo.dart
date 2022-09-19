import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/identity_repo.dart';

class IdentityRepoImpl implements IdentityRepo {
  @override
  Future<String> sendOTP(int mobileNumber) {
    // TODO: implement sendOTP
    return Future.delayed(const Duration(milliseconds: 100))
        .then((onValue) => "abc");
  }

  @override
  Future<Token> signInWithEmail(String email, String password) {
    // TODO: implement signInWithEmail
    return Future.delayed(const Duration(milliseconds: 100))
        .then((onValue) => Token("test", "test"));
  }

  @override
  Future<Token> verifyOTP(String verificationID, int mobileNumber, int otp) {
    // TODO: implement verifyOTP
    return Future.delayed(const Duration(milliseconds: 100))
        .then((onValue) => Token("test", "test"));
  }
}
