import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/utils/colors.dart';

class MeatMateBackButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? color;
  final Color? iconColor;
  final IconData? icon;
  final double? paddingHorizontal;
  const MeatMateBackButton(
      {super.key,
      this.onPressed,
      this.color,
      this.iconColor,
      this.icon,
      this.paddingHorizontal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          paddingHorizontal ?? 8.w, 0, paddingHorizontal ?? 8.w, 0),
      child: Container(
        height: 30.h,
        width: 30.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Colors.white38,
        ),
        child: IconButton(
          onPressed: onPressed ??
              () {
                Navigator.pop(context);
                /* var personnalDataProvider =
                    Provider.of<PersonnalDataProvider>(context, listen: false);*/
              },
          icon: Align(
            alignment: Alignment.center,
            child: Icon(
              icon ?? Icons.arrow_back_ios_rounded,
              color: iconColor ?? white,
              shadows: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 12,
                    offset: Offset(1, 1))
              ],
              size: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
