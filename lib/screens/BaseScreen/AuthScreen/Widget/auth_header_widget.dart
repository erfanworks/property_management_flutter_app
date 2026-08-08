import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';


class AuthHeaderWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;

  const AuthHeaderWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ConstColor.primaryColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: icon,
        ),
        SizedBox(height: 16.h),
        CustomText(
          title: title,
          textSize: 22.sp,
          fontWeight: FontWeight.w700,
          textColor: ConstColor.titleColor,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.h),
        CustomText(
          title: subtitle,
          textSize: 13.sp,
          textColor: ConstColor.bodyColor,
          textAlign: TextAlign.center,
          maxLine: 2,
        ),
      ],
    );
  }
}