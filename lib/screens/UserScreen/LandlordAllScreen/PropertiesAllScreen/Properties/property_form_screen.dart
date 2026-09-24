// lib/screens/UserScreen/LandlordAllScreen/Properties/property_form_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../models/property_model.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomDateField/custom_date_field.dart';
import '../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/properties_controller.dart';

class PropertyFormScreen extends GetView<PropertiesController> {
  const PropertyFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: controller.isEditing ? ConstString.editProperty : ConstString.addProperty),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomText(title: ConstString.photos, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
            SizedBox(height: 10.h),
            if (controller.formPhotoPaths.isNotEmpty) ...[
              SizedBox(
                height: 80.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.formPhotoPaths.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Stack(
                      children: [
                        AppImage(filePath: controller.formPhotoPaths[index], width: 80.w, height: 80.h, fit: BoxFit.cover),
                        Positioned(
                          top: 2.h,
                          right: 2.w,
                          child: GestureDetector(
                            onTap: () => controller.removePhoto(index),
                            child: CircleAvatar(radius: 10.r, backgroundColor: Colors.black54, child: Icon(Icons.close_rounded, size: 12.sp, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
            GestureDetector(
              onTap: () => _pickPhoto(controller),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  border: Border.all(color: ConstColor.primaryColor.withAlpha(60)),
                  borderRadius: BorderRadius.circular(12.r),
                  color: ConstColor.infoBg,
                ),
                child: Column(
                  children: [
                    Icon(Icons.add_photo_alternate_outlined, color: ConstColor.primaryColor, size: 24.sp),
                    SizedBox(height: 6.h),
                    CustomText(
                      title: controller.formPhotoPaths.isEmpty ? ConstString.addPropertyPhotos : ConstString.managePropertyPhotos,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      textColor: ConstColor.primaryColor,
                    ),
                    if (controller.formPhotoPaths.isEmpty) ...[
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomText(title: ConstString.addPhotosHelper, textSize: 11.sp, textColor: ConstColor.bodyColor, textAlign: TextAlign.center, maxLine: 2),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomText(title: ConstString.propertyDetails, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
            SizedBox(height: 10.h),
            CustomTextFormField(
              fromTitle: ConstString.propertyNameLabel,
              textController: controller.nameController,
              hintText: CustomText(title: ConstString.propertyNameHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            CustomTextFormField(
              fromTitle: ConstString.streetAddress,
              textController: controller.addressController,
              hintText: CustomText(title: ConstString.streetAddressHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            CustomTextFormField(
              fromTitle: ConstString.postcode,
              textController: controller.postcodeController,
              hintText: CustomText(title: ConstString.postcodeHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            SizedBox(height: 6.h),
            CustomDropdownField<PropertyType>(
              label: ConstString.propertyTypeLabel,
              value: controller.formPropertyType.value,
              hintText: controller.isEditing ? ConstString.selectType : ConstString.selectTypeOptional,
              items: PropertyType.values.map((t) => DropdownMenuItem(value: t, child: CustomText(title: t.label, textSize: 14.sp))).toList(),
              onChanged: (v) => controller.formPropertyType.value = v,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Checkbox(value: controller.isHmo.value, onChanged: (v) => controller.isHmo.value = v ?? false, activeColor: ConstColor.primaryColor),
                Expanded(child: CustomText(title: ConstString.hmoLabel, textSize: 13.sp, textColor: ConstColor.titleColor, maxLine: 2)),
              ],
            ),
            CustomText(title: ConstString.hmoHelper, textSize: 11.sp, textColor: ConstColor.bodyColor, maxLine: 2),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    fromTitle: ConstString.yearBuilt,
                    textController: controller.yearBuiltController,
                    keyboardType: TextInputType.number,
                    numeric: true,
                    hintText: CustomText(title: ConstString.yearBuiltHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(child: CustomDateField(label: ConstString.datePurchased, date: controller.formDatePurchased.value, onTap: () => controller.pickFormDate(context, controller.formDatePurchased))),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    fromTitle: ConstString.valuation,
                    textController: controller.valuationController,
                    keyboardType: TextInputType.number,
                    numeric: true,
                    hintText: CustomText(title: ConstString.valuationHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(child: CustomDateField(label: ConstString.valuationDate, date: controller.formValuationDate.value, onTap: () => controller.pickFormDate(context, controller.formValuationDate))),
              ],
            ),
            if (controller.isEditing) ...[
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      fromTitle: ConstString.totalSizeSqft,
                      textController: controller.totalSizeController,
                      keyboardType: TextInputType.number,
                      numeric: true,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomTextFormField(
                      fromTitle: ConstString.alarmCode,
                      textController: controller.alarmCodeController,
                      hintText: CustomText(title: ConstString.alarmCodeHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CustomText(title: ConstString.furnished, textSize: 14.sp, fontWeight: FontWeight.w600),
              CustomText(title: ConstString.furnishedHelper, textSize: 11.sp, textColor: ConstColor.bodyColor, maxLine: 2),
            ],
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: CustomDropdownField<EpcRating>(
                    label: ConstString.epcRatingLabel,
                    value: controller.formEpcRating.value,
                    hintText: ConstString.selectRating,
                    items: EpcRating.values.map((r) => DropdownMenuItem(value: r, child: CustomText(title: r.label, textSize: 14.sp))).toList(),
                    onChanged: (v) => controller.formEpcRating.value = v,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(child: CustomDateField(label: ConstString.epcExpiry, date: controller.formEpcExpiry.value, onTap: () => controller.pickFormDate(context, controller.formEpcExpiry))),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(child: CustomDateField(label: ConstString.insuranceRenewal, date: controller.formInsuranceRenewal.value, onTap: () => controller.pickFormDate(context, controller.formInsuranceRenewal))),
                SizedBox(width: 12.w),
                Expanded(
                  child: controller.isEditing
                      ? CustomDateField(label: ConstString.mortgageRenewal, date: controller.formMortgageRenewal.value, onTap: () => controller.pickFormDate(context, controller.formMortgageRenewal))
                      : CustomDropdownField<CouncilTaxBand>(
                    label: ConstString.councilTax,
                    value: controller.formCouncilTaxBand.value,
                    hintText: ConstString.selectBand,
                    items: CouncilTaxBand.values.map((b) => DropdownMenuItem(value: b, child: CustomText(title: b.label, textSize: 14.sp))).toList(),
                    onChanged: (v) => controller.formCouncilTaxBand.value = v,
                  ),
                ),
              ],
            ),
            if (controller.isEditing) ...[
              SizedBox(height: 14.h),
              CustomDropdownField<CouncilTaxBand>(
                label: ConstString.councilTax,
                value: controller.formCouncilTaxBand.value,
                hintText: ConstString.selectBand,
                items: CouncilTaxBand.values.map((b) => DropdownMenuItem(value: b, child: CustomText(title: b.label, textSize: 14.sp))).toList(),
                onChanged: (v) => controller.formCouncilTaxBand.value = v,
              ),
            ],
            SizedBox(height: 16.h),
            CustomText(title: '${ConstString.notesOptionalLabel} (optional)', textSize: 14.sp, fontWeight: FontWeight.w600),
            SizedBox(height: 8.h),
            CustomTextFormField(
              fromTitle: ConstString.buildingNotes,
              textController: controller.notesController,
              hintText: CustomText(title: ConstString.buildingNotesHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
              maxLine: 4,
              minLines: 4,
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              onPressed: controller.canSubmitRx.value && !controller.isSubmitting.value ? controller.submitProperty : null,
              child: CustomText(
                title: controller.isSubmitting.value ? ConstString.saving : (controller.isEditing ? ConstString.saveChanges : ConstString.saveProperty),
                textColor: Colors.white,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickPhoto(PropertiesController controller) async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
        if (file != null) controller.addPickedPhoto(file.path);
      },
      onGallery: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
        if (file != null) controller.addPickedPhoto(file.path);
      },
    );
  }
}