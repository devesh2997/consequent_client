import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/jwt_repo.dart';

class TokenStore {
  final TokenRepo repo;

  TokenStore(this.repo);

  Future<void> storeToken(Token jwt) {
    return repo.storeToken(jwt);
  }

  Future<String?> getJWT() {
    return repo.getJWT();
  }

  Future<String?> getRefreshToken() {
    return repo.getRefreshToken();
  }
}
