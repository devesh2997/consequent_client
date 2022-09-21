class JWTTokenDTO {
  final String token;

  JWTTokenDTO(this.token);

  factory JWTTokenDTO.fromJson(Map<String, dynamic> json) {
    return JWTTokenDTO(json['token']);
  }

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

class RefreshTokenDTO {
  final String token;

  RefreshTokenDTO(this.token);

  factory RefreshTokenDTO.fromJson(Map<String, dynamic> json) {
    return RefreshTokenDTO(json['token']);
  }

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

class TokenDTO {
  final JWTTokenDTO jwt;
  final RefreshTokenDTO refreshToken;

  TokenDTO(this.jwt, this.refreshToken);

  factory TokenDTO.fromJson(Map<String, dynamic> json) {
    return TokenDTO(
      JWTTokenDTO.fromJson(json["jwt"]),
      RefreshTokenDTO.fromJson(json["refresh_token"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "jwt": jwt.toJson(),
        "refresh_token": refreshToken.toJson(),
      };
}
