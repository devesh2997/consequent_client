import 'package:consequent_client/presentation/widgets/buttons/toggle_theme_button.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget? defaultAppBar() {
  return AppBar(
    actions: [
      ToggleTheme(),
    ],
  );
}
