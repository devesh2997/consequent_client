import 'package:consequent_client/presentation/pages/login.dart';
import 'package:consequent_client/presentation/pages/splash.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consequent',
      theme: ThemeData(
        primaryColor: Colors.indigoAccent,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        dividerColor: Colors.white54,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(
                secondary: Colors.indigo.shade100,
                brightness: Brightness.light),
        highlightColor: Colors.blue,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.indigo.shade900,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF212121),
        dividerColor: Colors.black12,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(
                secondary: Colors.indigo.shade900, brightness: Brightness.dark),
        highlightColor: Colors.pink,
      ),
      themeMode: ThemeMode.light,
      home: const Login(),
    );
  }
}
