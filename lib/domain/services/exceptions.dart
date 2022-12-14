class APIException implements Exception {
  final String? err;

  APIException(
      this.err); // TODO (devesh2997) | these types of exception should be sent to logging service
  @override
  String toString() {
    return err ?? "Some error occurred. Please try again later.";
  }
}

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
    return "Password must be atleast 6 characters long.";
  }
}

class ConfirmPasswordMismatchException implements Exception {
  @override
  String toString() {
    return "Password and Confirm Password mismatch";
  }
}
