import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Function()? onTap;
  final Color? textColor;
  final Color? color;
  final Widget? leading;
  final double? width;
  final Color? inkColor;
  const LargeButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.textColor,
      this.color,
      this.leading,
      this.width,
      this.style,
      this.inkColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.sp),
        child: Material(
          color: transparent,
          child: InkResponse(
            splashColor: inkColor ?? const Color.fromARGB(255, 255, 0, 98),
            onTap: onTap ?? () {},
            child: Ink(
              height: 45.h,
              width: width ?? 225.w,
              decoration: BoxDecoration(
                color: color ?? black,
                borderRadius: BorderRadius.circular(25.sp),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      leading ?? const SizedBox(),
                      leading != null ? Gap(20.w) : const SizedBox(),
                      Text(
                        text,
                        style: style ?? normalWhiteStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
