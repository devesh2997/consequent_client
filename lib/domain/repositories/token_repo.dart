import 'package:consequent_client/domain/entities/token.dart';

abstract class TokenRepo {
  Future<void> storeToken(Token token);
  Future<Token?> getToken();
  Future<void> deleteToken();
}
