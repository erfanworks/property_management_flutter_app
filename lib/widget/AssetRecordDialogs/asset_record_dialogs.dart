// lib/common_widget/asset_dialog/asset_record_dialogs.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/const_color.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/payment_record_detail_screen.dart';
import '../AppImage/app_image.dart';
import '../ConfirmActionDialog/confirm_action_dialog.dart';
import '../CustomDateField/custom_date_field.dart';
import '../CustomElevatedButton/custom_elevated_button.dart';
import '../CustomTextFormField/custom_text_form_field.dart';
import '../text/custom_text.dart';
import '../../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/controller/asset_records_controller.dart';
import '../../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/model/asset_record_model.dart';

class AssetRecordDialogs {
  static void showDetail(AssetRecordModel record, AssetRecordsController controller) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(controller.type.icon, size: 20.sp, color: ConstColor.primaryColor),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: record.name, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                        CustomText(title: controller.type.detailSubtitle, textSize: 11.sp, textColor: ConstColor.bodyColor),
                      ],
                    ),
                  ),
                  GestureDetector(onTap: Get.back, child: Icon(Icons.close_rounded, size: 20.sp, color: ConstColor.bodyColor)),
                ],
              ),
              if (record.photoPath != null) ...[
                SizedBox(height: 12.h),
                ClipRRect(borderRadius: BorderRadius.circular(12.r), child: AppImage(path: record.photoPath, width: double.infinity, height: 130.h, fit: BoxFit.cover)),
              ],
              SizedBox(height: 10.h),
              if (controller.type.isAppliance) ...[
                DetailRow(label: 'Brand & Model', value: record.secondaryLabel),
                DetailRow(label: 'Warranty', value: record.warranty.isEmpty ? '-' : record.warranty, isLast: true),
              ] else ...[
                DetailRow(label: 'Location', value: record.secondaryLabel),
                DetailRow(label: 'Expiry / Test Due', value: record.expiryOrWarrantyLabel.replaceFirst('Exp: ', '')),
                DetailRow(label: 'Status', value: record.isRecorded ? 'Active' : 'Inactive', isLast: true),
              ],
              SizedBox(height: 16.h),
              CustomElevatedButton(
                onPressed: () {
                  Get.back();
                  showEdit(record, controller);
                },
                icon: Icon(Icons.edit_outlined, color: Colors.white, size: 16.sp),
                child: CustomText(title: controller.type.editButtonLabel, textColor: Colors.white, textSize: 13.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showEdit(AssetRecordModel? record, AssetRecordsController controller) {
    if (record != null) {
      controller.startEdit(record);
    } else {
      controller.startAdd();
    }
    Get.dialog(_AssetFormDialog(record: record, controller: controller));
  }
}

class _AssetFormDialog extends StatelessWidget {
  const _AssetFormDialog({required this.record, required this.controller});
  final AssetRecordModel? record;
  final AssetRecordsController controller;

  @override
  Widget build(BuildContext context) {
    final isEdit = record != null;
    return Obx(
          () => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: CustomText(title: isEdit ? 'Edit' : controller.type.addTitle, textSize: 16.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor)),
                  GestureDetector(onTap: Get.back, child: Icon(Icons.close_rounded, size: 20.sp, color: ConstColor.bodyColor)),
                ],
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: controller.pickFormPhoto,
                child: Container(
                  width: double.infinity,
                  height: 100.h,
                  decoration: BoxDecoration(border: Border.all(color: ConstColor.dividerColor), borderRadius: BorderRadius.circular(12.r)),
                  child: controller.formPhotoPath.value != null
                      ? ClipRRect(borderRadius: BorderRadius.circular(12.r), child: AppImage(path: controller.formPhotoPath.value, fit: BoxFit.cover))
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined, color: ConstColor.primaryColor, size: 22.sp),
                      SizedBox(height: 4.h),
                      CustomText(title: isEdit ? 'Tap to change photo' : 'Upload or take photo', textSize: 12.sp, fontWeight: FontWeight.w600, textColor: ConstColor.primaryColor),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              CustomTextFormField(fromTitle: controller.type.nameLabel, textController: controller.nameController, hintText: CustomText(title: controller.type.nameHint, textColor: ConstColor.bodyColor, textSize: 14.sp)),
              if (controller.type.isAppliance) ...[
                CustomTextFormField(fromTitle: 'Brand / Manufacturer', textController: controller.secondaryController, hintText: CustomText(title: 'e.g. Bosch, Samsung, Worcester, Beko', textColor: ConstColor.bodyColor, textSize: 14.sp)),
                CustomTextFormField(fromTitle: 'Model / Type', textController: controller.modelTypeController),
                CustomTextFormField(fromTitle: 'Warranty / Cover Details', textController: controller.warrantyController),
              ] else ...[
                CustomTextFormField(fromTitle: 'Location in Property', textController: controller.secondaryController, hintText: CustomText(title: 'e.g. Boiler Room', textColor: ConstColor.bodyColor, textSize: 14.sp)),
                CustomDateField(label: 'Expiry Date / Battery Due', date: controller.formExpiryDate.value, onTap: () async {
                  final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2100));
                  if (picked != null) controller.formExpiryDate.value = picked;
                }),
              ],
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: Get.back,
                      isOutLined: true,
                      outLineColour: ConstColor.dividerColor,
                      child: CustomText(title: 'Cancel', textColor: ConstColor.titleColor, textSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        controller.saveForm();
                        Get.back();
                      },
                      child: CustomText(title: isEdit ? 'Save Changes' : controller.type.saveLabel, textColor: Colors.white, textSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              if (isEdit) ...[
                SizedBox(height: 8.h),
                CustomElevatedButton(
                  onPressed: () {
                    Get.back();
                    ConfirmActionDialog.show(
                      title: controller.type.deleteButtonLabel,
                      message: 'This cannot be undone.',
                      confirmLabel: 'Delete',
                      onConfirm: () => controller.deleteRecord(record!.id),
                    );
                  },
                  isOutLined: true,
                  outLineColour: ConstColor.errorColor,
                  height: 40,
                  child: CustomText(title: controller.type.deleteButtonLabel, textColor: ConstColor.errorColor, textSize: 13.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}