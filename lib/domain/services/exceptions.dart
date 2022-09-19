class InvalidMobileException implements Exception {
  @override
  String toString() {
    return "Invalid mobile number";
  }
}

class InvalidOTPException implements Exception {
  @override
  String toString() {
    return "Invalid OTP";
  }
}

class InvalidEmailException implements Exception {
  @override
  String toString() {
    return "Invalid email";
  }
}

class InvalidPasswordException implements Exception {
  @override
  String toString() {
    return "Invalid password";
  }
}
