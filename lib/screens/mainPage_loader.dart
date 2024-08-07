import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:meal_mate/utils/theme_extensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainPageLoader extends StatelessWidget {
  const MainPageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120.w),
                child: Center(
                  child: Shimmer.fromColors(
                      period: const Duration(milliseconds: 1000),
                      highlightColor: Colors.grey[100]!,
                      baseColor: Colors.grey[300]!,
                      child: Container(
                        height: 160.h,
                        width: 160.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Shimmer.fromColors(
                    period: const Duration(milliseconds: 1000),
                    highlightColor: Colors.grey[100]!,
                    baseColor: Colors.grey[300]!,
                    child: Container(
                      height: 115.h,
                      width: 250.w,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.sp)),
                          color: Colors.grey),
                    )),
              ),
              Gap(22.h),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                padding: const EdgeInsets.all(16.0),
                children: [
                  Shimmer.fromColors(
                      period: Duration(milliseconds: 1000),
                      highlightColor: Colors.grey[100]!,
                      baseColor: Colors.grey[300]!,
                      child: Container(
                        height: 160.h,
                        width: 145.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.sp)),
                            color: Colors.grey),
                      )),
                  Shimmer.fromColors(
                      period: Duration(milliseconds: 1000),
                      highlightColor: Colors.grey[100]!,
                      baseColor: Colors.grey[300]!,
                      child: Container(
                        height: 160.h,
                        width: 145.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.sp)),
                            color: Colors.grey),
                      )),
                  Shimmer.fromColors(
                      period: Duration(milliseconds: 1000),
                      highlightColor: Colors.grey[100]!,
                      baseColor: Colors.grey[300]!,
                      child: Container(
                        height: 160.h,
                        width: 145.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.sp)),
                            color: Colors.grey),
                      )),
                  Shimmer.fromColors(
                      period: Duration(milliseconds: 1000),
                      highlightColor: Colors.grey[100]!,
                      baseColor: Colors.grey[300]!,
                      child: Container(
                        height: 160.h,
                        width: 145.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.sp)),
                            color: Colors.grey),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
