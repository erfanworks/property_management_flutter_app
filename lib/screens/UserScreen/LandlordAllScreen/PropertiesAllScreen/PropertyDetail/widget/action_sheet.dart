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
  final Color? iconBg;
  final VoidCallback onTap;
  const ActionSheetItem({
    required this.label,
    this.icon,
    this.color,
    this.iconBg,
    required this.onTap,
  });
}

class CustomActionSheet {
  static Future<void> show(
    List<ActionSheetItem> items, {
    String? title,
  }) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Row(
                children: [
                  SizedBox(width: 32.r),
                  Expanded(
                    child: Center(
                      child: CustomText(
                        title: title,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        textColor: ConstColor.titleColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 32.r,
                      height: 32.r,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F5F8),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 18.sp,
                        color: ConstColor.titleColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ] else ...[
              SizedBox(height: 6.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 12.h),
            ],
            ...List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index > 0)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: const Color(0xFFF2F4F7),
                    ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      item.onTap();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Row(
                        children: [
                          if (item.icon != null) ...[
                            Container(
                              width: 40.r,
                              height: 40.r,
                              decoration: BoxDecoration(
                                color: item.iconBg ??
                                    (item.color != null
                                        ? item.color!.withAlpha(25)
                                        : ConstColor.primaryColor.withAlpha(25)),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                item.icon,
                                color: item.color ?? ConstColor.titleColor,
                                size: 18.sp,
                              ),
                            ),
                            SizedBox(width: 14.w),
                          ],
                          Expanded(
                            child: CustomText(
                              title: item.label,
                              textSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              textColor: ConstColor.titleColor,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 18.sp,
                            color: const Color(0xFFD0D5DD),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
            if (title == null) ...[
              SizedBox(height: 8.h),
              ListTile(
                title: Center(
                  child: CustomText(
                    title: 'Cancel',
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.bodyColor,
                  ),
                ),
                onTap: () => Get.back(),
              ),
            ],
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}