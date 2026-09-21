// lib/common_widget/appbar/brand_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_icons.dart';
import '../../../../../widget/text/custom_text.dart';

/// GlobalAppBar centerWidget — reused across every role's main tab screens.
class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key, required this.title, required this.tagline});

  final String title;
  final String tagline;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(
            color: ConstColor.primaryColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              ConstIcons.homeTabIcon,
              width: 18.sp,
              height: 18.sp,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(title: title, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.primaryColor),
            CustomText(title: tagline, textSize: 10.sp, textColor: ConstColor.bodyColor),
          ],
        ),
      ],
    );
  }
}