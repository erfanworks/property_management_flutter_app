import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/const_color.dart';
import '../text/custom_text.dart';

class MediaPickerBottomSheet {
  static Future<void> show({
    required VoidCallback onGallery,
    required VoidCallback onCamera,
  }) async {
    await Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            CustomText(
              title: "Select Image Source", // Replace with ConstString if available
              textSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 20.h),

            ListTile(
              leading: Icon(Icons.camera_alt, size: 28.sp, color: ConstColor.primaryColor),
              title: CustomText(
                title: "Camera", // Replace with ConstString if available
                textSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              onTap: () {
                Get.back();
                onCamera();
              },
            ),

            ListTile(
              leading: Icon(Icons.photo_library, size: 28.sp, color: ConstColor.primaryColor),
              title: CustomText(
                title: "Gallery", // Replace with ConstString if available
                textSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              onTap: () {
                Get.back();
                onGallery();
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}