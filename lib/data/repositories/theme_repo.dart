import 'package:consequent_client/domain/repositories/theme_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const darkThemeKey = "is_dark_theme";

class ThemeRepoImpl implements ThemeRepo {
  @override
  Future<bool> isDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isDarkTheme = prefs.getBool(darkThemeKey);

    return isDarkTheme ?? false;
  }

  @override
  Future<void> setDarkTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(darkThemeKey, isDarkTheme);
  }
}
