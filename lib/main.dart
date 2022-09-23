import 'package:consequent_client/presentation/controllers/identity_controller.dart';
import 'package:consequent_client/presentation/controllers/theme_controller.dart';
import 'package:consequent_client/presentation/pages/home.dart';
import 'package:consequent_client/presentation/pages/splash.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_login/with_login.dart';
import 'package:consequent_client/presentation/widgets/hocs/with_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(IdentityController());
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WithTheme(WithLogin(
      const Home(),
    ));
  }
}
