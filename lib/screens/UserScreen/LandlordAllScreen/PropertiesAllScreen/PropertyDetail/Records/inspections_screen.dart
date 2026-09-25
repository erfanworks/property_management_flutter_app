// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/inspections_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/inspections_controller.dart';

class InspectionsScreen extends StatelessWidget {
  const InspectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InspectionsController());
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: 'Inspections',
        actions: [
          GestureDetector(
            onTap: controller.openConduct,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ConstColor.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: 'Conduct',
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(16.r),
          itemCount: controller.inspections.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final r = controller.inspections[index];
            return GestureDetector(
              onTap: () => controller.openReport(r),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: ConstColor.titleColor.withAlpha(30))
                ),
                child: Row(
                  children: [
                    Icon(
                      r.isCommunal
                          ? Icons.apartment_rounded
                          : Icons.door_front_door_outlined,
                      size: 20.sp,
                      color: ConstColor.primaryColor,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: r.areaLabel,
                            textSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            textColor: ConstColor.titleColor,
                          ),
                          CustomText(
                            title: r.typeLabel,
                            textSize: 12.sp,
                            textColor: ConstColor.bodyColor,
                          ),
                          CustomText(
                            title: r.dateLabel,
                            textSize: 11.sp,
                            textColor: ConstColor.bodyColor,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18.sp,
                      color: ConstColor.bodyColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
