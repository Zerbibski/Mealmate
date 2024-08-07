import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';

class RoundedTextButton extends StatefulWidget {
  final String text;
  final Color? startColor;
  final Color? endColor;
  final double? width;
  final Function()? onPressed;
  final EdgeInsetsGeometry? buttonMargin;
  final Icon? icon;
  final TextStyle? style;
  final double? height;
  final double? borderRadius;
  const RoundedTextButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width,
      this.startColor,
      this.endColor,
      this.buttonMargin,
      this.icon,
      this.style,
      this.height,
      this.borderRadius});

  @override
  State<RoundedTextButton> createState() => _RoundedTextButtonState();
}

class _RoundedTextButtonState extends State<RoundedTextButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.buttonMargin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 18.sp),
          border: Border.all(color: white, width: 0.40.w),
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              colors: [
                widget.startColor ?? Colors.lightBlueAccent,
                widget.endColor ?? Colors.blueAccent,
              ]),
          boxShadow: [
            BoxShadow(
              offset: Offset(2.w, 2.h),
              blurRadius: 2,
              color: Colors.black26,
            ),
          ]),
      height: widget.height ?? 40.h,
      child: TextButton(
        onPressed: widget.onPressed ?? () {},
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(const Color(0xFF2C4ED2)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 18.sp)),
          ),
        ),
        child: widget.icon != null
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: widget.icon != null
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: [
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: widget.icon ?? const SizedBox()),
                    SizedBox(
                      width: 15.w,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.text,
                        style: widget.style ?? normalWhiteStyle,
                      ),
                    ),
                  ],
                ),
              )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.text,
                  style: widget.style ?? normalWhiteStyle,
                ),
              ),
      ),
    );
  }
}
