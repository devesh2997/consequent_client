import 'package:consequent_client/data/dtos/token.dart';
import 'package:consequent_client/domain/entities/token.dart';

class JWTTokenMapper {
  JWTToken toEntity(JWTTokenDTO dto) {
    return JWTToken(dto.token);
  }

  JWTTokenDTO toModel(JWTToken jwt) {
    return JWTTokenDTO(jwt.token);
  }
}

class RefreshTokenMapper {
  RefreshToken toEntity(RefreshTokenDTO dto) {
    return RefreshToken(dto.token);
  }

  RefreshTokenDTO toModel(RefreshToken refreshToken) {
    return RefreshTokenDTO(refreshToken.token);
  }
}

class TokenMapper {
  Token toEntity(TokenDTO dto) {
    return Token(JWTTokenMapper().toEntity(dto.jwt),
        RefreshTokenMapper().toEntity(dto.refreshToken));
  }

  TokenDTO toModel(Token token) {
    return TokenDTO(JWTTokenMapper().toModel(token.jwt),
        RefreshTokenMapper().toModel(token.refreshToken));
  }
}
