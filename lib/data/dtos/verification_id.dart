class VerificationID {
  final String verificationID;

  VerificationID(this.verificationID);

  factory VerificationID.fromJson(dynamic json) {
    return VerificationID(json["verification_id"]);
  }
}
