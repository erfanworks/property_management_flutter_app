// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/widget/upload_document_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../../constant/const_color.dart';
import '../../../../../../../../widget/text/custom_text.dart';
import '../../controller/property_detail_controller.dart';
import '../../model/property_detail_model.dart';

class UploadDocumentBottomSheet extends StatelessWidget {
  const UploadDocumentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertyDetailController>();
    final tenant = controller.selectedTenant.value;
    final locationLabel = tenant != null
        ? '${tenant.unitLabel} · ${tenant.propertyName}'
        : 'Flat 2A · 12 Park Lane';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(width: 32.r),
              Expanded(
                child: CustomText(
                  title: 'Upload document',
                  textSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.titleColor,
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8.r),
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
          SizedBox(height: 12.h),
          CustomText(
            title: locationLabel.toUpperCase(),
            textSize: 10.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.bodyColor.withAlpha(200),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.sp,
                color: ConstColor.bodyColor,
              ),
              children: [
                const TextSpan(text: 'Choose what you are uploading for '),
                TextSpan(
                  text: locationLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          ...UploadDocCategory.values.map(
            (category) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  controller.pickAndUploadTenantDocument(category);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38.r,
                        height: 38.r,
                        decoration: BoxDecoration(
                          color: category.bgColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          category.icon,
                          color: category.iconColor,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomText(
                          title: category.label,
                          textSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          textColor: ConstColor.titleColor,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 20.sp,
                        color: const Color(0xFFCBD5E1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
