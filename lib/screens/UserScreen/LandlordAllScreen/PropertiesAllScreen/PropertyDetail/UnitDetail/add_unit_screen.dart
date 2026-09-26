// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/add_unit_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/unit_detail_controller.dart';
import 'model/unit_profile_model.dart';

class AddUnitScreen extends GetView<UnitDetailController> {
  const AddUnitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.addUnit),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            if (controller.formPhotoPaths.isNotEmpty) ...[
              SizedBox(
                height: 76.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.formPhotoPaths.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    final isCover = index == controller.formCoverIndex.value;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Stack(children: [
                        AppImage(filePath: controller.formPhotoPaths[index], width: 76.w, height: 76.h, fit: BoxFit.cover),
                        Positioned(top: 3.h, right: 3.w, child: GestureDetector(onTap: () => controller.setCoverPhoto(index, forForm: true), child: CircleAvatar(radius: 11.r, backgroundColor: Colors.black45, child: Icon(isCover ? Icons.star_rounded : Icons.star_border_rounded, size: 14.sp, color: isCover ? Colors.amber : Colors.white)))),
                      ]),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
            ],
            GestureDetector(
              onTap: () => controller.addUnitPhoto(forForm: true),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18.h),
                decoration: BoxDecoration(border: Border.all(color: ConstColor.primaryColor.withAlpha(60)), borderRadius: BorderRadius.circular(12.r), color: ConstColor.infoBg),
                child: Column(children: [
                  Icon(Icons.add_photo_alternate_outlined, color: ConstColor.primaryColor, size: 22.sp),
                  SizedBox(height: 6.h),
                  CustomText(title: 'Add flat photos (optional)', textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.primaryColor),
                  SizedBox(height: 4.h),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20.w), child: CustomText(title: 'Add multiple photos and tap the star icon to choose which shows on the home screen.', textSize: 11.sp, textColor: ConstColor.bodyColor, textAlign: TextAlign.center, maxLine: 2)),
                ]),
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(fromTitle: 'Unit name', textController: controller.unitNameController, hintText: CustomText(title: 'e.g. Flat 5', textColor: ConstColor.bodyColor, textSize: 14.sp)),
            CustomTextFormField(fromTitle: 'Rent per month (£)', textController: controller.rentController, keyboardType: TextInputType.number, numeric: true),
            Row(
              children: [
                Expanded(child: CustomTextFormField(fromTitle: 'Beds', textController: controller.bedsController, keyboardType: TextInputType.number, numeric: true)),
                SizedBox(width: 10.w),
                Expanded(child: CustomTextFormField(fromTitle: 'Baths', textController: controller.bathsController, keyboardType: TextInputType.number, numeric: true)),
                SizedBox(width: 10.w),
                Expanded(child: CustomTextFormField(fromTitle: 'Sq ft', textController: controller.sqftController, keyboardType: TextInputType.number, numeric: true)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomDropdownField<String>(
                    label: 'Floor',
                    value: controller.formFloor.value,
                    hintText: 'Select floor',
                    items: const ['1st Floor', '2nd Floor', '3rd Floor'].map((f) => DropdownMenuItem(value: f, child: CustomText(title: f, textSize: 14.sp))).toList(),
                    onChanged: (v) => controller.formFloor.value = v,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(child: CustomTextFormField(fromTitle: 'Floor note', textController: controller.floorNoteController, hintText: CustomText(title: 'e.g. Rear wing', textColor: ConstColor.bodyColor, textSize: 14.sp))),
              ],
            ),
            SizedBox(height: 6.h),
            CustomDropdownField<UnitTypeOption>(
              label: 'Unit type',
              value: controller.formUnitType.value,
              hintText: 'Same as building',
              items: UnitTypeOption.values.map((t) => DropdownMenuItem(value: t, child: CustomText(title: t.label, textSize: 14.sp))).toList(),
              onChanged: (v) => controller.formUnitType.value = v ?? UnitTypeOption.sameAsBuilding,
            ),
            SizedBox(height: 10.h),
            CustomDropdownField<FurnishedOption>(
              label: 'Furnished',
              value: controller.formFurnished.value,
              hintText: 'Not set',
              items: FurnishedOption.values.map((f) => DropdownMenuItem(value: f, child: CustomText(title: f.label, textSize: 14.sp))).toList(),
              onChanged: (v) => controller.formFurnished.value = v ?? FurnishedOption.notSet,
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.canSubmitUnitRx.value && !controller.isSubmittingUnit.value ? controller.submitAddUnit : null,
              child: CustomText(title: controller.isSubmittingUnit.value ? ConstString.saving : 'Save unit', textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}