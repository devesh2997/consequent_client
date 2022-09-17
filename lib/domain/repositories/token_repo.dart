import 'package:consequent_client/domain/entities/token.dart';

abstract class TokenRepo {
  Future<void> storeToken(Token jwt);
  Future<String?> getJWT();
  Future<String?> getRefreshToken();
  Future<void> deleteToken();
}
