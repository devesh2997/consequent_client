import 'package:consequent_client/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithTheme extends StatelessWidget {
  final ThemeController _controller = Get.find<ThemeController>();
  final Widget child;
  WithTheme(this.child, {Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Obx(
      () => _controller.isDarkTheme()
          ? Theme(
              data: ThemeData(
                primaryColor: Colors.indigo.shade900,
                brightness: Brightness.dark,
                backgroundColor: const Color(0xFF212121),
                dividerColor: Colors.black12,
                colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
                        .copyWith(
                  secondary: Colors.indigo.shade400,
                  brightness: Brightness.dark,
                  surface: Colors.indigo.shade900,
                ),
                highlightColor: Colors.pink,
              ),
              child: child,
            )
          : Theme(
              data: ThemeData(
                primaryColor: Colors.indigoAccent,
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                dividerColor: Colors.white54,
                colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
                        .copyWith(
                            secondary: Colors.indigo.shade600,
                            brightness: Brightness.light),
                highlightColor: Colors.blue,
              ),
              child: child,
            ),
    );
  }
}
