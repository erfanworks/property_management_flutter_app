import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';

/// Reused by Tenant & Contractor Profile screens (hamburger icon + title,
/// stacked). Static for now — drawer will be wired later.
class ProfileMenuHeader extends StatelessWidget {
  final String title;

  const ProfileMenuHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.menu_rounded, size: 26.sp, color: ConstColor.titleColor), // TODO: wire drawer later
          SizedBox(height: 10.h),
          CustomText(
            title: title,
            textSize: 22.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.titleColor,
          ),
        ],
      ),
    );
  }
}