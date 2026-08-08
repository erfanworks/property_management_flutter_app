import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';

/// Reused 3x on Role Select screen (Landlord/Tenant/Contractor rows).
class RoleSelectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleSelectionCard({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isSelected,
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
          color: isSelected ? ConstColor.primaryColor.withAlpha(15) : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? ConstColor.primaryColor : ConstColor.bodyColor.withAlpha(60),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(12.r)),
              child: Icon(icon, color: iconColor, size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.titleColor,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(title: subtitle, textSize: 12.sp, textColor: ConstColor.bodyColor),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? ConstColor.primaryColor : ConstColor.bodyColor,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}