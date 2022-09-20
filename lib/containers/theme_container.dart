import 'package:consequent_client/data/repositories/theme_repo.dart';
import 'package:consequent_client/domain/services/theme_service.dart';

ThemeService injectThemeService() {
  var identityRepo = ThemeRepoImpl();

  return ThemeServiceImpl(repo: identityRepo);
}
