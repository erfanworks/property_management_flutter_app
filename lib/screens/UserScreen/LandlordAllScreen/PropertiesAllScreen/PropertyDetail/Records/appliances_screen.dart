// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/appliances_screen.dart
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

class AppliancesScreen extends StatelessWidget {
  const AppliancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      AssetRecordsController(AssetRecordType.appliance),
      tag: 'appliance',
    );
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: 'Appliances',
        actions: [
          AppBarTextAction(
            label: 'Add',
            icon: Icons.add_rounded,
            onTap: () => AssetRecordDialogs.showEdit(null, controller),
          ),
        ],
      ),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomDropdownField<FlatFilterModel>(
              value: controller.selectedFlatFilter.value,
              items: controller.flatFilters
                  .map(
                    (f) => DropdownMenuItem(
                      value: f,
                      child: CustomText(title: f.label, textSize: 14.sp),
                    ),
                  )
                  .toList(),
              onChanged: controller.selectFlatFilter,
            ),
            SizedBox(height: 8.h),
            CustomText(
              title: 'FLAT 1 APPLIANCES (${controller.filteredRecords.length})',
              textSize: 10.sp,
              fontWeight: FontWeight.w600,
              textColor: ConstColor.bodyColor,
              letterSpacing: 0.4,
            ),
            SizedBox(height: 10.h),
            ...controller.filteredRecords.map(
              (r) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: GestureDetector(
                  onTap: () => AssetRecordDialogs.showDetail(r, controller),
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: r.photoPath != null
                              ? AppImage(
                                  path: r.photoPath,
                                  width: 44.r,
                                  height: 44.r,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 44.r,
                                  height: 44.r,
                                  color: ConstColor.dividerColor,
                                  child: Icon(
                                    Icons.build_circle_outlined,
                                    color: ConstColor.bodyColor,
                                  ),
                                ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: r.name,
                                textSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                textColor: ConstColor.titleColor,
                              ),
                              CustomText(
                                title: r.secondaryLabel,
                                textSize: 11.sp,
                                textColor: ConstColor.bodyColor,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: ConstColor.dividerColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CustomText(
                            title: r.expiryOrWarrantyLabel,
                            textSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            textColor: ConstColor.titleColor,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
