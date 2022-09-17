import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/token_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const jwtKey = "jwt";
const refreshTokenKey = "refresh_token";

class TokenRepoImpl implements TokenRepo {
  final storage = const FlutterSecureStorage();
  @override
  Future<String?> getJWT() {
    return storage.read(key: jwtKey);
  }

  @override
  Future<void> storeToken(Token jwt) {
    return storage.write(key: jwtKey, value: jwt.jet).then((value) =>
        storage.write(key: refreshTokenKey, value: jwt.refreshToken));
  }

  @override
  Future<String?> getRefreshToken() {
    return storage.read(key: refreshTokenKey);
  }

  @override
  Future<void> deleteToken() {
    return storage
        .delete(key: refreshTokenKey)
        .then((value) => storage.delete(key: jwtKey));
  }
}
