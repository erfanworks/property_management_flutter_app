// lib/common_widget/dialog/confirm_action_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/const_color.dart';
import '../CustomElevatedButton/custom_elevated_button.dart';
import '../text/custom_text.dart';

class ConfirmActionDialog {
  static Future<void> show({
    required String title,
    required String message,
    required String confirmLabel,
    required VoidCallback onConfirm,
    String cancelLabel = 'Cancel', // Replace with ConstString if available
  }) {
    return Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(title: title, textSize: 16.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
              SizedBox(height: 8.h),
              CustomText(title: message, textSize: 13.sp, textColor: ConstColor.bodyColor, maxLine: 3),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: Get.back,
                      isOutLined: true,
                      elevation: 0,
                      outLineColour: ConstColor.dividerColor,
                      height: 44,
                      child: CustomText(title: cancelLabel, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        Get.back();
                        onConfirm();
                      },
                      color: ConstColor.errorColor,
                      height: 44,
                      child: CustomText(title: confirmLabel, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}