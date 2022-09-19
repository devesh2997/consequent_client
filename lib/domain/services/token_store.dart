import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/token_repo.dart';

abstract class TokenStore {
  Future<void> storeToken(Token jwt);
  Future<String?> getJWT();
  Future<String?> getRefreshToken();
  Future<void> deleteToken();
}

class TokenStoreImpl implements TokenStore {
  final TokenRepo repo;

  TokenStoreImpl(this.repo);

  @override
  Future<void> storeToken(Token jwt) {
    return repo.storeToken(jwt);
  }

  @override
  Future<String?> getJWT() {
    return repo.getJWT();
  }

  @override
  Future<String?> getRefreshToken() {
    return repo.getRefreshToken();
  }

  @override
  Future<void> deleteToken() {
    return repo.deleteToken();
  }
}
