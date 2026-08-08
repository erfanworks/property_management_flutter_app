/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../constant/const_color.dart';
import '../text/custom_text.dart';
import '../../../utils/app_role.dart';
import '../../../routes/app_routes/app_routes.dart';

class DemoRoleBottomSheet extends StatelessWidget {
  const DemoRoleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Handle ───
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ConstColor.iconColor.withAlpha(100),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 24.h),

          // ─── Title ───
          CustomText(
            title: 'Select Demo Experience',
            textColor: ConstColor.titleColor,
            textSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 8.h),
          CustomText(
            title: 'Which dashboard would you like to explore?',
            textColor: ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),

          // ─── User Role Card ───
          _RoleCard(
            icon: 'assets/icons/profile_icon.svg',
            title: 'User',
            subtitle: 'Browse properties, save favorites & send enquiries.',
            color: ConstColor.primaryColor,
            onTap: () {
              selectedUserRole = AppUserType.user;
              // Get.offAllNamed(AppRoutes.navBar);
            },
          ),
          SizedBox(height: 16.h),

          // ─── Agent Role Card ───
          _RoleCard(
            icon: 'assets/icons/agent_role_icon.svg',
            title: 'Agent',
            subtitle: 'Manage listings, track leads & view performance.',
            color: ConstColor.secondaryColor,
            onTap: () {
              selectedUserRole = AppUserType.agent; // Set global role
              // Get.offAllNamed(AppRoutes.navBar);    // Navigate to NavBar
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

// ─── Reusable Role Card ───
class _RoleCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: ConstColor.outLineColor),
          borderRadius: BorderRadius.circular(16.r),
          color: color.withAlpha(10), // Very light background
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(icon, width: 24.w, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    textColor: ConstColor.titleColor,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    title: subtitle,
                    textColor: ConstColor.bodyColor,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 2,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: ConstColor.iconColor),
          ],
        ),
      ),
    );
  }
}*/
