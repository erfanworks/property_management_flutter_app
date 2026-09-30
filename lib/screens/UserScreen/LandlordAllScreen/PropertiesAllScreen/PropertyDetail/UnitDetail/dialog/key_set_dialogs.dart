// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/dialog/key_set_dialogs.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../constant/const_color.dart';
import '../../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../../widget/text/custom_text.dart';
import '../controller/unit_detail_controller.dart';
import '../model/unit_profile_model.dart';

class KeySetDialogs {
  static void showDetail(UnitKeySetModel keySet, UnitDetailController controller) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(18.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: ConstColor.infoBg,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.vpn_key_outlined,
                      size: 20.sp,
                      color: ConstColor.primaryColor,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomText(
                      title: keySet.keyType,
                      textSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      textColor: ConstColor.titleColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 32.r,
                      height: 32.r,
                      decoration: BoxDecoration(
                        color: ConstColor.titleColor.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 18.sp,
                        color: ConstColor.bodyColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Divider(
                color: ConstColor.dividerColor.withAlpha(120),
                height: 1,
                thickness: 1,
              ),
              SizedBox(height: 14.h),
              _DialogFieldRow(
                label: 'Key Type / Tag',
                valueWidget: CustomText(
                  title: keySet.keyType,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.titleColor,
                ),
              ),
              SizedBox(height: 10.h),
              _DialogFieldRow(
                label: 'Quantity',
                valueWidget: CustomText(
                  title: '${keySet.quantity} Sets',
                  textSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.titleColor,
                ),
              ),
              SizedBox(height: 10.h),
              _DialogFieldRow(
                label: 'Location / Access',
                valueWidget: CustomText(
                  title: keySet.locationTag,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.titleColor,
                ),
              ),
              SizedBox(height: 10.h),
              _DialogFieldRow(
                label: 'Current Custody',
                valueWidget: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ConstColor.infoBg,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: ConstColor.primaryColor.withAlpha(40),
                    ),
                  ),
                  child: CustomText(
                    title: keySet.custodyLabel,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      height: 42,
                      buttonBorderRadius: 12,
                      onPressed: () {
                        Get.back();
                        controller.startEditKeySet(keySet);
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      iconGap: 6,
                      child: CustomText(
                        title: 'Edit Key',
                        textColor: Colors.white,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      controller.deleteKeySet(keySet.id);
                    },
                    child: Container(
                      width: 42.r,
                      height: 42.r,
                      decoration: BoxDecoration(
                        color: ConstColor.errorBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: ConstColor.errorColor,
                        size: 20.sp,
                      ),
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

class _DialogFieldRow extends StatelessWidget {
  const _DialogFieldRow({
    required this.label,
    required this.valueWidget,
  });

  final String label;
  final Widget valueWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: label,
            textSize: 12.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.bodyColor,
          ),
          valueWidget,
        ],
      ),
    );
  }
}
