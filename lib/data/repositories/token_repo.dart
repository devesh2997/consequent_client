import 'dart:convert';

import 'package:consequent_client/data/dtos/token.dart';
import 'package:consequent_client/data/mappers/token.dart';
import 'package:consequent_client/datasources/secure_local_storage.dart';
import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/token_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const tokenKey = "token";

class TokenRepoImpl implements TokenRepo {
  final SecureLocalStorage storage;

  TokenRepoImpl(this.storage);

  @override
  Future<void> storeToken(Token token) {
    var tokenDTO = TokenMapper().toModel(token);

    String tokenStr = jsonEncode(tokenDTO.toJson());
    return storage.set(key: tokenKey, value: tokenStr);
  }

  @override
  Future<void> deleteToken() {
    return storage.delete(key: tokenKey);
  }

  @override
  Future<Token?> getToken() async {
    String? tokenStr = await storage.get(key: tokenKey);
    if (tokenStr == null) {
      return null;
    }
    TokenDTO tokenDTO = TokenDTO.fromJson(jsonDecode(tokenStr));

    return TokenMapper().toEntity(tokenDTO);
  }
}
