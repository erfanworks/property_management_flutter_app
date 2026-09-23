// lib/screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/assign_contractor_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/maintenance_controller.dart';
import 'widget/contractor_tile.dart';

class AssignContractorScreen extends GetView<MaintenanceController> {
  const AssignContractorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.maintenanceIssue),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              hintText: CustomText(title: ConstString.searchContractorsHint, textColor: ConstColor.bodyColor, textSize: 13.sp),
              prefixIcon: Icon(Icons.search_rounded, color: ConstColor.bodyColor, size: 20.sp),
            ),
            SizedBox(height: 8.h),
            Obx(() {
              final issueType = controller.selectedIssue.value?.issueType.label ?? '';
              final count = controller.contractors.length;
              return CustomText(title: '${ConstString.suggestedForPrefix} $issueType · $count ${ConstString.contractorsSuffix}', textSize: 12.sp, textColor: ConstColor.bodyColor);
            }),
            SizedBox(height: 12.h),
            Expanded(
              child: Obx(
                    () => ListView.separated(
                  itemCount: controller.contractors.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final contractor = controller.contractors[index];
                    return ContractorTile(
                      data: contractor,
                      trailing: SizedBox(
                        height: 28.h,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: ConstColor.primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                          ),
                          onPressed: () => controller.assignContractor(contractor),
                          child: CustomText(title: ConstString.assign, textColor: Colors.white, textSize: 12.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}