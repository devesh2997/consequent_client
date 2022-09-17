abstract class IdentityRepo {
  Future<void> isLoggedIn();
  Future<void> sendOTP(int mobileNumber);
  Future<bool> verifyOTP(int mobileNumber, int otp);
}
