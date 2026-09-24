// lib/common_widget/action_sheet/custom_action_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/text/custom_text.dart';

class ActionSheetItem {
  final String label;
  final IconData? icon;
  final Color? color;
  final VoidCallback onTap;
  const ActionSheetItem({required this.label, this.icon, this.color, required this.onTap});
}

class CustomActionSheet {
  static Future<void> show(List<ActionSheetItem> items) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.r))),
            SizedBox(height: 6.h),
            ...items.map(
                  (item) => ListTile(
                leading: item.icon != null ? Icon(item.icon, color: item.color ?? ConstColor.titleColor, size: 20.sp) : null,
                title: CustomText(title: item.label, textSize: 14.sp, fontWeight: FontWeight.w600, textColor: item.color ?? ConstColor.titleColor),
                onTap: () {
                  Get.back();
                  item.onTap();
                },
              ),
            ),
            ListTile(
              title: Center(child: CustomText(title: 'Cancel', textSize: 14.sp, fontWeight: FontWeight.w500, textColor: ConstColor.bodyColor)), // Replace with ConstString if available
              onTap: () => Get.back(),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}