import 'package:consequent_client/presentation/widgets/buttons/toggle_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

PreferredSizeWidget? defaultAppBar() {
  return NeumorphicAppBar(
    actions: [
      ToggleTheme(),
    ],
  );
}
