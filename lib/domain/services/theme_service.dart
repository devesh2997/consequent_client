import 'package:consequent_client/domain/repositories/theme_repo.dart';

typedef ThemeChangeCallback = void Function(bool isDarkTheme);

abstract class ThemeService {
  Future<bool> isDarkTheme();
  Future<void> setDarkTheme(bool isDarkTheme);
  void onThemeChange(ThemeChangeCallback callback);
}

class ThemeServiceImpl implements ThemeService {
  final ThemeRepo repo;
  final List<ThemeChangeCallback> _callbacks = [];

  ThemeServiceImpl({required this.repo});

  @override
  Future<bool> isDarkTheme() {
    return repo.isDarkTheme();
  }

  @override
  void onThemeChange(ThemeChangeCallback callback) {
    _callbacks.add(callback);
  }

  @override
  Future<void> setDarkTheme(bool isDarkTheme) async {
    await repo.setDarkTheme(isDarkTheme);
    _notifyThemeChange(isDarkTheme);
  }

  _notifyThemeChange(bool isDarkTheme) {
    for (var callback in _callbacks) {
      callback(isDarkTheme);
    }
  }
}
