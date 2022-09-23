import 'package:consequent_client/domain/entities/token.dart';

abstract class IdentityRepo {
  Future<String> sendOTP(int mobileNumber);
  Future<Token> verifyOTP(String verificationID, int mobileNumber, int otp);
  Future<Token> signInWithEmail(String email, String password);
  Future<Token> signUpWithEmail(String email, String password);
  Future<bool> isEmailRegistered(String email);
}
