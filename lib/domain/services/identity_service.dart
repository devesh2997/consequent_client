import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/identity_repo.dart';
import 'package:consequent_client/domain/repositories/token_repo.dart';

abstract class IdentiyService {
  Future<bool> isLoggedIn();
  Future<void> sendOTP(int mobileNumber);
  Future<Token> verifyOTP(int mobileNumber, int otp);
  Future<Token> signInWithEmail(String email, String password);
  Future<void> logout();
}

class IdentityServiceImpl implements IdentiyService {
  final IdentityRepo repo;
  final TokenRepo tokenRepo;

  IdentityServiceImpl(this.repo, this.tokenRepo);

  @override
  Future<bool> isLoggedIn() async {
    try {
      String? refreshToken = await tokenRepo.getRefreshToken();
      if (refreshToken == null) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> sendOTP(int mobileNumber) {
    // TODO: (devesh2997) | validate mobile number
    return repo.sendOTP(mobileNumber);
  }

  @override
  Future<Token> signInWithEmail(String email, String password) {
    // TODO: (devesh2997) | validate email and password here
    return repo.signInWithEmail(email, password);
  }

  @override
  Future<Token> verifyOTP(int mobileNumber, int otp) {
    return repo.verifyOTP(mobileNumber, otp);
  }

  @override
  Future<void> logout() {
    return tokenRepo.deleteToken();
  }
}
