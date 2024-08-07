import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:meal_mate/animations/custom_page_transitions.dart';
import 'package:meal_mate/screens/fridge.dart';
import 'package:meal_mate/screens/profile.dart';
import 'package:meal_mate/screens/recipes.dart';
import 'package:meal_mate/services/auth.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/widgets/background_animated.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      color1: const Color.fromARGB(255, 255, 227, 167),
      color2: white,
      color3: const Color.fromARGB(255, 255, 227, 167),
      color4: const Color.fromARGB(255, 244, 108, 54),
      color5: const Color.fromARGB(255, 255, 227, 167),
      child: Scaffold(
        backgroundColor: transparent,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 30,
                ),
                color: black,
                onPressed: () async {
                  _authService.logout(context);
                },
              ),
            ),
          ],
          backgroundColor: transparent,
        ),
        body: Column(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/logo/logo_launch.png',
                scale: 8,
              ),
            ),
            Gap(20.h),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Goals',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Omnes'),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NutrientGauge(
                            label: 'lipids',
                            value: 32,
                            maxValue: 79,
                          ),
                          NutrientGauge(
                            label: 'proteins',
                            value: 87,
                            maxValue: 99,
                          ),
                          NutrientGauge(
                            label: 'carbs',
                            value: 125,
                            maxValue: 279,
                          ),
                          NutrientGauge(
                            label: 'fibers',
                            value: 22,
                            maxValue: 79,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              padding: const EdgeInsets.all(16.0),
              children: [
                ToolButton(
                  iconData: Icons.menu_book,
                  label: 'Recipes',
                  onTap: () {
                    CustomPageTransition.smoothPageTransition(
                        context, const Recipes(), 'Go_To_Recipes');
                  },
                ),
                ToolButton(
                  label: 'Fridge',
                  iconData: Icons.kitchen,
                  onTap: () {
                    CustomPageTransition.smoothPageTransition(
                        context, const Fridge(), 'Go_To_Fridge');
                  },
                ),
                ToolButton(
                  label: 'Profile',
                  iconData: Icons.settings,
                  onTap: () {
                    CustomPageTransition.smoothPageTransition(
                        context, const Profile(), 'Go_To_Profile');
                  },
                ),
                ToolButton(
                  label: 'Past recipes',
                  iconData: Icons.history,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NutrientGauge extends StatelessWidget {
  final String label;
  final int value;
  final int maxValue;

  const NutrientGauge(
      {super.key,
      required this.label,
      required this.value,
      required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 75.h,
          width: 75.w,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: maxValue.toDouble(),
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.2,
                  cornerStyle: CornerStyle.bothCurve,
                  color: Colors.grey.shade300,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: value.toDouble(),
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                    cornerStyle: CornerStyle.bothCurve,
                    color: Colors.blue,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      '$value /\n $maxValue g',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.1,
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class ToolButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final IconData iconData;

  const ToolButton(
      {super.key, required this.label, this.onTap, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Passez directement la fonction onTap
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(50.h),
              Icon(
                iconData,
                color: Colors.white,
              ),
              Gap(10.h),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
