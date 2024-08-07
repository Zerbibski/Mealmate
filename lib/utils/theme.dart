import 'package:flutter/material.dart';
import 'package:meal_mate/utils/colors.dart';

ThemeData light_mode = ThemeData(
    brightness: Brightness.light,
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Comfortaa'),
    colorScheme: ColorScheme.light(
      background: white,
      primary: darkBlue,
      secondary: Color(0XFF303030),
      tertiary: Colors.blue.shade100, // RequestContainer
      onPrimary: black, // Texte sur les éléments principaux
      surface: Color(0xFFE0E0E0), // Couleur des surfaces avec opacity
      onBackground: darkBlue,
      onSecondary: darkBlue, // APPBAR
      onSurface: white, // Texte sur les surfaces
      brightness: Brightness.light,
    ));

ThemeData dark_mode = ThemeData(
  brightness: Brightness.dark,
  textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Comfortaa'),
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF121212), // Couleur de fond très foncée
    primary: Color.fromARGB(
        255, 29, 29, 29), // Bleu foncé pour les éléments principaux
    secondary: Color(0xFF64B5F6), // Bleu clair pour les éléments secondaires
    tertiary: Color.fromARGB(255, 58, 26, 26), // RequestContainer
    onPrimary: white, // Texte sur les éléments principaux
    surface: Color(0xFF121212), // Couleur des surfaces
    onBackground: white, // Texte sur le fond
    onSecondary: Color.fromARGB(255, 58, 58, 58), // APPBAR
    onSurface: Color.fromARGB(255, 58, 58, 58), // Texte sur les surfaces
    brightness: Brightness.dark,
  ),
);
