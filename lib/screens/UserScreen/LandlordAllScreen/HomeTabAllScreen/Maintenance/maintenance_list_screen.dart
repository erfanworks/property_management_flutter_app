// lib/screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/maintenance_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imusa04_landlord_app/widget/CustomStatusChip/custom_status_chip.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../../../../models/property_model.dart';
import 'controller/maintenance_controller.dart';
import 'model/maintenance_issue_model.dart';

class MaintenanceListScreen extends GetView<MaintenanceController> {
  const MaintenanceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.maintenance,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.logIssueScreen),
            icon: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(color: ConstColor.primaryColor, borderRadius: BorderRadius.circular(8.r)),
              child: Icon(Icons.add_rounded, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            CustomTextFormField(
              backgroundColor: Colors.white,
              hintText: CustomText(title: ConstString.searchIssuesHint, textColor: ConstColor.bodyColor, textSize: 13.sp),
              prefixIcon: Icon(Icons.search_rounded, color: ConstColor.bodyColor, size: 20.sp),
              onChanged: controller.applySearch,
            ),
            SizedBox(height: 8.h),
            Obx(
                  () => Row(
                children: [
                  Expanded(
                    child: CustomDropdownField<PropertyModel?>(
                      backgroundColor: Colors.white,
                      value: controller.filterProperty.value,
                      hintText: ConstString.allProperties,
                      items: [
                        DropdownMenuItem(value: null, child: CustomText(title: ConstString.allProperties, textSize: 13.sp)),
                        ...controller.properties.map((p) => DropdownMenuItem(value: p, child: CustomText(title: p.name, textSize: 13.sp))),
                      ],
                      onChanged: controller.selectFilterProperty,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomDropdownField<UnitModel?>(
                      backgroundColor: Colors.white,
                      value: controller.filterUnit.value,
                      hintText: ConstString.allUnit,
                      items: [
                        DropdownMenuItem(value: null, child: CustomText(title: ConstString.allUnit, textSize: 13.sp)),
                        ...?controller.filterProperty.value?.units.map(
                              (u) => DropdownMenuItem(value: u, child: CustomText(title: u.label, textSize: 13.sp, maxLine: 1)),
                        ),
                      ],
                      onChanged: controller.selectFilterUnit,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Obx(() => _FilterTabs(
              selectedIndex: controller.selectedFilterTabIndex.value,
              allCount: controller.issues.length,
              tenantReportsCount: controller.tenantReportsCount,
              myLogsCount: controller.myLogsCount,
              onChanged: controller.selectFilterTab,
            )),
            SizedBox(height: 12.h),
            Expanded(
              child: Obx(() {
                final list = controller.filteredIssues;
                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) => _IssueTile(data: list[index], onTap: () => controller.openDetail(list[index])),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  const _FilterTabs({
    required this.selectedIndex,
    required this.allCount,
    required this.tenantReportsCount,
    required this.myLogsCount,
    required this.onChanged,
  });

  final int selectedIndex;
  final int allCount;
  final int tenantReportsCount;
  final int myLogsCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      (label: '${ConstString.all} ($allCount)', icon: null),
      (label: '${ConstString.tenantReports} ($tenantReportsCount)', icon: Icons.person_outline_rounded),
      (label: '${ConstString.myLogs} ($myLogsCount)', icon: Icons.article_outlined),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: List.generate(tabs.length, (index) {
        final isSelected = index == selectedIndex;
        final tab = tabs[index];
        return Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? ConstColor.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: isSelected ? ConstColor.primaryColor : ConstColor.dividerColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (tab.icon != null) ...[
                    Icon(tab.icon, size: 14.sp, color: isSelected ? Colors.white : ConstColor.bodyColor),
                    SizedBox(width: 4.w),
                  ],
                  CustomText(title: tab.label, textSize: 12.sp, fontWeight: FontWeight.w600, textColor: isSelected ? Colors.white : ConstColor.titleColor),
                ],
              ),
            ),
          ),
        );
      }),
    ));
  }
}

class _IssueTile extends StatelessWidget {
  const _IssueTile({required this.data, required this.onTap});
  final MaintenanceIssueModel data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: data.photoUrls.isNotEmpty
                  ? AppImage(path: data.photoUrls.first, width: 44.r, height: 44.r, fit: BoxFit.cover)
                  : Container(width: 44.r, height: 44.r, color: ConstColor.dividerColor),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: CustomText(title: data.title, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor, maxLine: 1)),
                      CustomText(title: data.reportedAgoLabel, textSize: 11.sp, textColor: ConstColor.bodyColor),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  CustomText(title: '${data.propertyName} · ${data.unitLabel}', textSize: 12.sp, textColor: ConstColor.bodyColor, maxLine: 1),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomStatusChip(label: data.status.label, color: data.status.color, backgroundColor: data.status.bg),
                              SizedBox(width: 6.w),
                              CustomStatusChip(label: data.priority.label, color: data.priority.color, backgroundColor: data.priority.bg),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (data.status == IssueStatus.open)
                        SizedBox(
                          height: 28.h,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: ConstColor.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                            ),
                            onPressed: onTap,
                            child: CustomText(title: ConstString.assign, textColor: Colors.white, textSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}