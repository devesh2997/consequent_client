import 'package:consequent_client/data/repositories/identity_repo.dart';
import 'package:consequent_client/data/repositories/token_repo.dart';
import 'package:consequent_client/datasources/secure_local_storage.dart';
import 'package:consequent_client/domain/services/identity_service.dart';
import 'package:consequent_client/domain/services/token_store.dart';

IdentityService injectIdentityService() {
  var identityRepo = IdentityRepoImpl();
  var tokenRepo = TokenRepoImpl(SecureLocalStorageImpl());
  var tokenStore = TokenStoreImpl(tokenRepo);

  return IdentityServiceImpl(repo: identityRepo, tokenStore: tokenStore);
}
