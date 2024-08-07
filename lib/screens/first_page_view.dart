import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:meal_mate/screens/background_screen.dart';
import 'package:meal_mate/screens/home.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';

class MyPageViewPresentation extends StatefulWidget {
  @override
  _MyPageViewPresentationState createState() => _MyPageViewPresentationState();
}

class _MyPageViewPresentationState extends State<MyPageViewPresentation> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Color> _pageColors = [
    const Color(0xFF5A56FB),
    white,
    const Color(0xFFFF9900),
  ];
  final List<Color> _circleFontColor = [
    const Color(0xFF5A56FB),
    white,
    const Color(0xFFFF9900),
  ];
  final List<Color> _circleColor = [
    white,
    black,
    white,
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Naviguer vers la page Home lorsque 'Go' est pressé
      Get.offAll(() => const BackgroundScreen(),
          transition: Transition.rightToLeft);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: _pageColors[_currentPage],
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const <Widget>[
                Page(
                  pretitle: "Get started with",
                  title: "Meal Meat",
                  description: "The Global Nutrition Application",
                  fontColor: Colors.white,
                  lottiePath: "assets/lotties/1.json",
                ),
                Page(
                  pretitle: "Have a goal ?",
                  title: "Define your goal simply !",
                  description:
                      "You can adjust the nutrient rate you need as best as possible",
                  fontColor: Colors.black,
                  lottiePath: "assets/lotties/2.json",
                ),
                Page(
                  pretitle: "Don't know what to eat?",
                  title: "Meal Meat propose you a lot of choice",
                  description:
                      "No need to search, Meal Meat already worked for you",
                  lottiePath: "assets/lotties/3.json",
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40.h,
            left: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: _currentPage == index ? 15.w : 10.w,
                  height: 10.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentPage == index
                        ? _currentPage == 1
                            ? const Color(0xFF5A56FB)
                            : Colors.white
                        : Colors.black.withOpacity(0.3),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 40.h,
            right: 40.h,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _circleColor[_currentPage],
              ),
              child: TextButton(
                onPressed: _nextPage,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Text(
                    _currentPage == 2 ? 'Go' : 'Next',
                    style: TextStyle(color: _circleFontColor[_currentPage]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final String pretitle;
  final String title;
  final String description;
  final Color? fontColor;
  final String lottiePath;

  const Page({
    required this.pretitle,
    required this.title,
    required this.description,
    this.fontColor,
    required this.lottiePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Gap(MediaQuery.of(context).size.height / 6),
          Hero(tag: 'switch', child: Lottie.asset(lottiePath)),
          Gap(20.h),
          Text(pretitle,
              style: normalTheWhiteOmnesStyle.copyWith(color: fontColor)),
          Text(
            title,
            style: bigBoldWhiteOmnes.copyWith(color: fontColor),
            textAlign: TextAlign.center,
          ),
          Gap(12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(description,
                textAlign: TextAlign.center,
                style: normalWhiteOmnesStyle.copyWith(color: fontColor)),
          ),
          Gap(12.h),
          const Spacer(),
        ],
      ),
    );
  }
}
