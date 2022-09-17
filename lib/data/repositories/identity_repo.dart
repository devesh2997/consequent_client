import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/identity_repo.dart';

class IdentityRepoImpl implements IdentityRepo {
  @override
  Future<void> sendOTP(int mobileNumber) {
    // TODO: implement sendOTP
    throw UnimplementedError();
  }

  @override
  Future<Token> signInWithEmail(String email, String password) {
    // TODO: implement signInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Token> verifyOTP(int mobileNumber, int otp) {
    // TODO: implement verifyOTP
    throw UnimplementedError();
  }
}
