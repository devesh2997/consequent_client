import 'package:consequent_client/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleTheme extends StatelessWidget {
  final ThemeController _controller = Get.find<ThemeController>();
  ToggleTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        onPressed: _controller.toggleDarkTheme,
        icon: Icon(
          Icons.lightbulb_rounded,
          color: _controller.isDarkTheme() ? Colors.white : Colors.yellow,
        ),
      ),
    );
  }
}
