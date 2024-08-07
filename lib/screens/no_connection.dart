import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';
import 'package:meal_mate/utils/theme_extensions.dart';
import 'package:meal_mate/widgets/text_button.dart';

class NoConnectionPage extends StatelessWidget {
  final VoidCallback onRetry;

  const NoConnectionPage({super.key, required this.onRetry});

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: FutureBuilder(
        future: _simulateLoading(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/NoInternetPNG.png',
                      color: context.BlackWhite,
                      scale: 5,
                    ),
                    Gap(10.h),
                    Text(
                      'CheckInternet'.tr,
                      style: normalBlackStyle.copyWith(
                          color: context.BlackWhite, fontSize: 18.0.sp),
                      textAlign: TextAlign.center,
                    ),
                    Gap(20.h),
                    RoundedTextButton(
                      onPressed: onRetry,
                      text: 'Retry'.tr,
                      startColor: pinkColor,
                      endColor: pinkColor,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
