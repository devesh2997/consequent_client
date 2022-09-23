import 'package:consequent_client/presentation/controllers/theme_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class ToggleTheme extends StatelessWidget {
  final ThemeController _controller = Get.find<ThemeController>();
  ToggleTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NeumorphicButton(
        style: const NeumorphicStyle(
          depth: 2,
        ),
        onPressed: _controller.toggleDarkTheme,
        child: Center(
          child: NeumorphicIcon(
            Icons.lightbulb_rounded,
            style: NeumorphicStyle(
              color: _controller.isDarkTheme() ? Colors.white : Colors.yellow,
            ),
            size: 28,
          ),
        ),
      ),
    );
  }
}
