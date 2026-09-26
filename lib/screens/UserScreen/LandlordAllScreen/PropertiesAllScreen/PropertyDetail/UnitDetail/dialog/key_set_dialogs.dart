// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/dialog/key_set_dialogs.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../constant/const_color.dart';
import '../../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../../widget/text/custom_text.dart';
import '../../../../HomeTabAllScreen/Finance/payment_record_detail_screen.dart';
import '../controller/unit_detail_controller.dart';
import '../model/unit_profile_model.dart';

class KeySetDialogs {
  static void showDetail(UnitKeySetModel keySet, UnitDetailController controller) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.vpn_key_outlined, size: 20.sp, color: ConstColor.primaryColor),
                  SizedBox(width: 8.w),
                  Expanded(child: CustomText(title: keySet.keyType, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor)),
                  GestureDetector(onTap: Get.back, child: Icon(Icons.close_rounded, size: 20.sp, color: ConstColor.bodyColor)),
                ],
              ),
              SizedBox(height: 10.h),
              DetailRow(label: 'Key Type / Tag', value: keySet.keyType),
              DetailRow(label: 'Quantity', value: '${keySet.quantity} Sets'),
              DetailRow(label: 'Location / Access', value: keySet.locationTag),
              DetailRow(label: 'Current Custody', value: keySet.custodyLabel, isLast: true),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        Get.back();
                        controller.startEditKeySet(keySet);
                      },
                      icon: Icon(Icons.edit_outlined, color: Colors.white, size: 16.sp),
                      child: CustomText(title: 'Edit Key', textColor: Colors.white, textSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      controller.deleteKeySet(keySet.id);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(color: ConstColor.errorBg, borderRadius: BorderRadius.circular(12.r)),
                      child: Icon(Icons.delete_outline_rounded, color: ConstColor.errorColor, size: 20.sp),
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