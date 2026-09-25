// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/safety_alarms_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/AssetRecordDialogs/asset_record_dialogs.dart';
import '../../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/asset_records_controller.dart';
import 'model/asset_record_model.dart';

class SafetyAlarmsScreen extends StatelessWidget {
  const SafetyAlarmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AssetRecordsController(AssetRecordType.safetyAlarm), tag: 'safety_alarm');
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: 'Safety & Alarms',
        actions: [AppBarTextAction(label: 'Add', icon: Icons.add_rounded, onTap: () => AssetRecordDialogs.showEdit(null, controller))],
      ),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomDropdownField<FlatFilterModel>(
              value: controller.selectedFlatFilter.value,
              items: controller.flatFilters.map((f) => DropdownMenuItem(value: f, child: CustomText(title: f.label, textSize: 14.sp))).toList(),
              onChanged: controller.selectFlatFilter,
            ),
            SizedBox(height: 14.h),
            ...controller.filteredRecords.map((r) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: _AssetTile(record: r, controller: controller),
            )),
          ],
        ),
      ),
    );
  }
}

class _AssetTile extends StatelessWidget {
  const _AssetTile({required this.record, required this.controller});
  final AssetRecordModel record;
  final AssetRecordsController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AssetRecordDialogs.showDetail(record, controller),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: record.photoPath != null
                  ? AppImage(path: record.photoPath, width: 44.r, height: 44.r, fit: BoxFit.cover)
                  : Container(width: 44.r, height: 44.r, color: ConstColor.dividerColor, child: Icon(controller.type.icon, color: ConstColor.bodyColor)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: record.name, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                  CustomText(title: record.secondaryLabel, textSize: 11.sp, textColor: ConstColor.bodyColor),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(color: ConstColor.dividerColor, borderRadius: BorderRadius.circular(20.r)),
              child: CustomText(title: record.expiryOrWarrantyLabel, textSize: 10.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
            ),
            Icon(Icons.chevron_right_rounded, size: 18.sp, color: ConstColor.bodyColor),
          ],
        ),
      ),
    );
  }
}