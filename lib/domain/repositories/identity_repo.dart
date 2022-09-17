import 'package:consequent_client/domain/entities/token.dart';

abstract class IdentityRepo {
  Future<void> sendOTP(int mobileNumber);
  Future<Token> verifyOTP(int mobileNumber, int otp);
  Future<Token> signInWithEmail(String email, String password);
}
