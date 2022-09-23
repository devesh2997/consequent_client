import 'package:consequent_client/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class WithTheme extends StatelessWidget {
  final ThemeController _controller = Get.find<ThemeController>();
  final Widget child;
  WithTheme(this.child, {Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Obx(() => NeumorphicApp(
          debugShowCheckedModeBanner: false,
          title: 'Neumorphic App',
          themeMode:
              _controller.isDarkTheme() ? ThemeMode.dark : ThemeMode.light,
          theme: const NeumorphicThemeData(
            baseColor: Color.fromARGB(255, 235, 235, 235),
            lightSource: LightSource.top,
            depth: 3,
          ),
          darkTheme: const NeumorphicThemeData(
            defaultTextColor: Colors.white,
            baseColor: Color.fromARGB(255, 20, 25, 38),
            lightSource: LightSource.top,
            depth: 1,
          ),
          home: child,
        ));
  }
}
