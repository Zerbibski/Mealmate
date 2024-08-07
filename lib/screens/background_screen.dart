import 'package:flutter/material.dart';
import 'package:meal_mate/screens/home.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/widgets/background_animated.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      color1: const Color.fromARGB(255, 255, 227, 167),
      color2: white,
      color3: const Color.fromARGB(255, 255, 227, 167),
      color4: const Color.fromARGB(255, 244, 108, 54),
      color5: const Color.fromARGB(255, 255, 227, 167),
      child: Container(
        color: transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Home(),
      ),
    );
  }
}
