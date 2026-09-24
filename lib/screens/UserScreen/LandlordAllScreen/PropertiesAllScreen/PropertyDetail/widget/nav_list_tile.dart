// lib/common_widget/list_tile/nav_list_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../../../widget/text/custom_text.dart';

class NavListTile extends StatelessWidget {
  const NavListTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: ConstColor.bodyColor.withAlpha(50)),
        ),
        child: Row(
          children: [
            CustomIconBadge(
              icon: icon,
              iconColor: iconColor,
              backgroundColor: iconBg,
              size: 38,
              isCircle: false,
              borderRadius: 10,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    textSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.titleColor,
                    maxLine: 1,
                  ),
                  if (subtitle != null)
                    CustomText(
                      title: subtitle!,
                      textSize: 11.sp,
                      textColor: ConstColor.bodyColor,
                      maxLine: 1,
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.sp,
              color: ConstColor.bodyColor,
            ),
          ],
        ),
      ),
    );
  }
}
