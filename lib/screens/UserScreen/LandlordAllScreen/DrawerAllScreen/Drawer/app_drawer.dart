// lib/screens/UserScreen/LandlordAllScreen/Drawer/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/app_drawer_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppDrawerController());
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(24.r), child: AppImage(url: controller.profile.value.avatarUrl, width: 48.r, height: 48.r, fit: BoxFit.cover)),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: controller.profile.value.name, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                        CustomText(title: controller.profile.value.roleLabel, textSize: 12.sp, textColor: ConstColor.bodyColor),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(color: ConstColor.dividerColor, height: 1),
              SizedBox(height: 8.h),
              _DrawerItem(icon: Icons.notifications_none_rounded, label: ConstString.smartReminders, onTap: controller.openSmartReminders),
              _DrawerItem(icon: Icons.people_outline_rounded, label: ConstString.tenants, onTap: controller.openTenants),
              _DrawerItem(icon: Icons.groups_outlined, label: ConstString.contractors, onTap: controller.openContractors),
              _DrawerItem(icon: Icons.help_outline_rounded, label: ConstString.helpAndFaq, onTap: controller.openHelpFaq),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: GestureDetector(
                  onTap: controller.logout,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(color: ConstColor.errorBg, borderRadius: BorderRadius.circular(12.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_rounded, size: 16.sp, color: ConstColor.errorColor),
                        SizedBox(width: 6.w),
                        CustomText(title: ConstString.logOut, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.errorColor),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20.sp, color: ConstColor.titleColor),
      title: CustomText(title: label, textSize: 14.sp, fontWeight: FontWeight.w500, textColor: ConstColor.titleColor),
      onTap: onTap,
    );
  }
}