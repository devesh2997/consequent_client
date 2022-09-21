class JWTToken {
  final String token;

  JWTToken(this.token);
}

class RefreshToken {
  final String token;

  RefreshToken(this.token);
}

class Token {
  final JWTToken jwt;
  final RefreshToken refreshToken;

  Token(this.jwt, this.refreshToken);
}
