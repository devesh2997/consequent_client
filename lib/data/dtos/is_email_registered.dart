class IsEmailRegistered {
  final bool registered;

  IsEmailRegistered(this.registered);

  factory IsEmailRegistered.fromJson(dynamic json) {
    return IsEmailRegistered(json["registered"]);
  }
}
