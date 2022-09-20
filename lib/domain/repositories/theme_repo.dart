abstract class ThemeRepo {
  Future<bool> isDarkTheme();
  Future<void> setDarkTheme(bool isDarkTheme);
}
