// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/inspection_report_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/inspections_controller.dart';

class InspectionReportScreen extends StatelessWidget {
  const InspectionReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InspectionsController());
    return Obx(() {
      final r = controller.selectedReport.value;
      if (r == null) return const Scaffold(body: SizedBox.shrink());
      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: 'Inspection Report'),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: ConstColor.titleColor.withAlpha(30))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: r.dateLabel.toUpperCase(),
                    textSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.bodyColor,
                    letterSpacing: 0.4,
                  ),
                  CustomText(
                    title: r.addressLabel ?? r.areaLabel,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.titleColor,
                  ),
                  if (r.inspectorNotes != null) ...[
                    SizedBox(height: 12.h),
                    CustomText(
                      title: 'INSPECTOR NOTES',
                      textSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      textColor: ConstColor.bodyColor,
                      letterSpacing: 0.4,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      title: r.inspectorNotes!,
                      textSize: 13.sp,
                      textColor: ConstColor.titleColor,
                      maxLine: 6,
                    ),
                  ],
                ],
              ),
            ),
            if (r.photoUrls.isNotEmpty) ...[
              SizedBox(height: 14.h),
              CustomText(
                title: 'Inspection Photos (${r.photoUrls.length})',
                textSize: 13.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.titleColor,
              ),
              SizedBox(height: 8.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 1.3,
                ),
                itemCount: r.photoUrls.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: AppImage(path: r.photoUrls[index], fit: BoxFit.cover),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
