import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/text/custom_text.dart';

/// Reused across all 3 role Profile screens.
class ProfileUserCard extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final String subtitle;
  final String? badgeText;
  final VoidCallback onTap;

  const ProfileUserCard({
    super.key,
    this.avatarUrl,
    required this.name,
    required this.subtitle,
    this.badgeText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            ClipOval(
              child: AppImage(url: avatarUrl, width: 48.w, height: 48.w, fit: BoxFit.cover),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: name,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.titleColor,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(title: subtitle, textSize: 12.sp, textColor: ConstColor.bodyColor),
                ],
              ),
            ),
            if (badgeText != null) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ConstColor.primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  title: badgeText!,
                  textSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.primaryColor,
                ),
              ),
              SizedBox(width: 6.w),
            ],
            Icon(Icons.chevron_right_rounded, color: ConstColor.bodyColor, size: 20.sp),
          ],
        ),
      ),
    );
  }
}