import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';
import 'package:meal_mate/utils/theme_extensions.dart';
import 'package:meal_mate/widgets/back_button.dart';

class ErrorWidgetDisplay extends StatelessWidget {
  const ErrorWidgetDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: AppBar(
          leading: MeatMateBackButton(
            color: transparent,
            iconColor: context.fontColor,
          ),
          centerTitle: true,
          title: Text(
            'Error'.tr,
            style: normalBlackStyle.copyWith(color: context.fontColor),
          ),
          backgroundColor: context.backgroundColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_outlined,
                color: context.fontColor,
                size: 50,
              ),
              Gap(5.h),
              Text(
                'ErrorOcured'.tr,
                style: normalBlackStyle.copyWith(color: context.fontColor),
              ),
              Gap(20.h),
            ],
          ),
        ));
  }
}
