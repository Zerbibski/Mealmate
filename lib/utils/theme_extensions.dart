import 'package:flutter/material.dart';

extension ThemeColors on BuildContext {
  Color get appBarColor => Theme.of(this).colorScheme.onSecondary;
  Color get backgroundColor => Theme.of(this).colorScheme.background;
  Color get fontColor => Theme.of(this).colorScheme.onBackground;
  Color get LightWhite_DarkGrey => Theme.of(this).colorScheme.onSurface;
  Color get LightBlue_DarkGrey => Theme.of(this).colorScheme.primary;
  Color get BlackWhite => Theme.of(this).colorScheme.onPrimary;
}
