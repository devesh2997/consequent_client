import 'package:consequent_client/datasources/local_storage.dart';
import 'package:consequent_client/domain/repositories/theme_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const darkThemeKey = "is_dark_theme";

class ThemeRepoImpl implements ThemeRepo {
  final LocalStorage storage;

  ThemeRepoImpl(this.storage);
  @override
  Future<bool> isDarkTheme() async {
    final bool? isDarkTheme = await storage.getBool(darkThemeKey);

    return isDarkTheme ?? false;
  }

  @override
  Future<void> setDarkTheme(bool isDarkTheme) async {
    await storage.setBool(darkThemeKey, isDarkTheme);
  }
}
