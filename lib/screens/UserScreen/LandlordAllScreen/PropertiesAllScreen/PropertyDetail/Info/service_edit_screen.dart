// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/service_edit_screen.dart
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
import '../controller/property_detail_controller.dart';
import '../model/service_model.dart';

class ServiceEditScreen extends GetView<PropertyDetailController> {
  const ServiceEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final service = controller.selectedService.value;
      if (service == null) return const Scaffold(body: SizedBox.shrink());

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: service.type.editTitle),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Row(
              children: [
                Icon(
                  service.type.icon,
                  size: 18.sp,
                  color: ConstColor.primaryColor,
                ),
                SizedBox(width: 8.w),
                CustomText(
                  title: service.type.label,
                  textSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.titleColor,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ...controller.editingFields.map((field) {
              if (field.dropdownOptions != null) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: CustomDropdownField<String>(
                    label: field.label,
                    value: field.value.isEmpty ? null : field.value,
                    hintText: field.label,
                    items: field.dropdownOptions!
                        .map(
                          (o) => DropdownMenuItem(
                            value: o,
                            child: CustomText(title: o, textSize: 14.sp),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => field.value = v ?? '',
                  ),
                );
              }
              return CustomTextFormField(
                fromTitle: field.label,
                textController: TextEditingController(text: field.value)
                  ..selection = TextSelection.collapsed(
                    offset: field.value.length,
                  ),
                maxLine: field.isMultiline ? 3 : 1,
                minLines: field.isMultiline ? 3 : null,
                onChanged: (v) => field.value = v,
              );
            }),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: ConstColor.titleColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    title: ConstString.changePhoto,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  if (controller.editingPhotoPath.value != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: AppImage(
                        filePath: controller.editingPhotoPath.value,
                        width: double.infinity,
                        height: 140.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                  CustomElevatedButton(
                    onPressed: controller.pickServicePhoto,
                    color: ConstColor.infoBg,
                    elevation: 0,
                    icon: Icon(
                      Icons.edit_outlined,
                      color: ConstColor.primaryColor,
                      size: 18.sp,
                    ),
                    child: CustomText(
                      title: ConstString.changePhoto,
                      textColor: ConstColor.primaryColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    title: ConstString.uploadPhotoHint,
                    textSize: 11.sp,
                    textColor: ConstColor.bodyColor,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.isSavingService.value
                  ? null
                  : controller.saveServiceEdit,
              child: CustomText(
                title: controller.isSavingService.value
                    ? ConstString.saving
                    : ConstString.saveChanges,
                textColor: Colors.white,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}
