import 'package:consequent_client/containers/theme_container.dart';
import 'package:consequent_client/domain/services/theme_service.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final ThemeService themeService = injectThemeService();

  final Rx<bool> _isDarkTheme = false.obs;

  @override
  void onInit() async {
    bool isDarkTheme = await themeService.isDarkTheme();
    _isDarkTheme.value = isDarkTheme;

    themeService.onThemeChange((isDarkTheme) {
      _isDarkTheme.value = isDarkTheme;
    });

    super.onInit();
  }

  bool isDarkTheme() {
    return _isDarkTheme.value;
  }

  void toggleDarkTheme() {
    themeService.setDarkTheme(!_isDarkTheme.value);
  }
}
