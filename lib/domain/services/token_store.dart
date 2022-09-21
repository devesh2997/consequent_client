import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/token_repo.dart';

abstract class TokenStore {
  Future<void> storeToken(Token jwt);
  Future<Token?> getToken();
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
  Future<void> deleteToken() {
    return repo.deleteToken();
  }

  @override
  Future<Token?> getToken() {
    return repo.getToken();
  }
}
