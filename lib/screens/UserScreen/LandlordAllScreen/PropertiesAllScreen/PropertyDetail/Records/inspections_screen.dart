// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/inspections_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/inspections_controller.dart';

class InspectionsScreen extends GetView<InspectionsController> {
  const InspectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: 'Inspections', actions: [AppBarTextAction(label: 'Conduct', icon: Icons.add_rounded, onTap: controller.openConduct)]),
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
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
                child: Row(
                  children: [
                    Icon(r.isCommunal ? Icons.apartment_rounded : Icons.door_front_door_outlined, size: 20.sp, color: ConstColor.primaryColor),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(title: r.areaLabel, textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                          CustomText(title: r.typeLabel, textSize: 12.sp, textColor: ConstColor.bodyColor),
                          CustomText(title: r.dateLabel, textSize: 11.sp, textColor: ConstColor.bodyColor),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, size: 18.sp, color: ConstColor.bodyColor),
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