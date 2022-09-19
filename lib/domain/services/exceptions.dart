class InvalidMobileException implements Exception {
  @override
  String toString() {
    return "Invalid mobile number";
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
