// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/dialog/inventory_dialogs.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../constant/const_color.dart';
import '../../../../../../../constant/const_string.dart';
import '../../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../../widget/ConfirmActionDialog/confirm_action_dialog.dart';
import '../../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../../../widget/text/custom_text.dart';
import '../controller/inventory_controller.dart';
import '../model/inventory_model.dart';

class InventoryDialogs {
  static void showRoomForm(InventoryController controller, {RoomModel? room}) {
    room != null ? controller.startEditRoom(room) : controller.startAddRoom();
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: room != null ? ConstString.editRoom : ConstString.addRoom, textSize: 16.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                        if (room == null) CustomText(title: ConstString.addRoomSubtitle, textSize: 11.sp, textColor: ConstColor.bodyColor),
                      ],
                    ),
                  ),
                  GestureDetector(onTap: Get.back, child: Icon(Icons.close_rounded, size: 20.sp, color: ConstColor.bodyColor)),
                ],
              ),
              SizedBox(height: 14.h),
              CustomTextFormField(
                fromTitle: ConstString.roomNameLabel,
                textController: controller.roomNameController,
                hintText: CustomText(title: ConstString.roomNameHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
              ),
              CustomTextFormField(
                fromTitle: ConstString.roomSizeOptional,
                textController: controller.roomSizeController,
                keyboardType: TextInputType.number,
                numeric: true,
                hintText: CustomText(title: ConstString.roomSizeHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                onPressed: () {
                  controller.saveRoom();
                  Get.back();
                },
                child: CustomText(title: room != null ? ConstString.saveChanges : ConstString.addRoom, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showItemForm(InventoryController controller, {InventoryItemModel? item}) {
    item != null ? controller.startEditItem(item) : controller.startAddItem();
    Get.dialog(
      Obx(
            () => Dialog(
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(title: item != null ? ConstString.editItem : ConstString.addItem, textSize: 16.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                          CustomText(title: item != null ? ConstString.editItemSubtitle : ConstString.addItemSubtitle, textSize: 11.sp, textColor: ConstColor.bodyColor),
                        ],
                      ),
                    ),
                    GestureDetector(onTap: Get.back, child: Icon(Icons.close_rounded, size: 20.sp, color: ConstColor.bodyColor)),
                  ],
                ),
                SizedBox(height: 14.h),
                CustomTextFormField(
                  fromTitle: item != null ? ConstString.itemNameLabel : ConstString.itemFixtureNameLabel,
                  textController: controller.itemNameController,
                  hintText: CustomText(title: ConstString.itemFixtureNameHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
                ),
                SizedBox(height: 4.h),
                CustomText(title: ConstString.photoLabel, textSize: 12.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                SizedBox(height: 6.h),
                GestureDetector(
                  onTap: controller.pickItemPhoto,
                  child: Container(
                    width: double.infinity,
                    height: item != null && controller.itemPhotoPath.value != null ? 110.h : 90.h,
                    decoration: BoxDecoration(border: Border.all(color: ConstColor.dividerColor), borderRadius: BorderRadius.circular(12.r)),
                    child: controller.itemPhotoPath.value != null
                        ? ClipRRect(borderRadius: BorderRadius.circular(12.r), child: AppImage(path: controller.itemPhotoPath.value, fit: BoxFit.cover))
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined, color: ConstColor.primaryColor, size: 22.sp),
                        SizedBox(height: 4.h),
                        CustomText(title: ConstString.tapToAddPhoto, textSize: 12.sp, fontWeight: FontWeight.w600, textColor: ConstColor.primaryColor),
                      ],
                    ),
                  ),
                ),
                if (item != null && controller.itemPhotoPath.value != null) ...[
                  SizedBox(height: 8.h),
                  CustomElevatedButton(
                    onPressed: controller.pickItemPhoto,
                    isOutLined: true,
                    outLineColour: ConstColor.dividerColor,
                    height: 38,
                    icon: Icon(Icons.photo_camera_back_outlined, size: 15.sp, color: ConstColor.titleColor),
                    child: CustomText(title: ConstString.changePhoto, textColor: ConstColor.titleColor, textSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                ],
                SizedBox(height: 16.h),
                CustomElevatedButton(
                  onPressed: () {
                    controller.saveItem();
                    Get.back();
                  },
                  icon: item == null ? Icon(Icons.add_rounded, color: Colors.white, size: 18.sp) : null,
                  child: CustomText(title: item != null ? ConstString.saveChanges : ConstString.addItem, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void confirmDeleteRoom(InventoryController controller, String id) {
    ConfirmActionDialog.show(title: ConstString.deleteProperty.replaceAll('property', 'room'), message: 'Remove this room and all its items? This cannot be undone.', confirmLabel: ConstString.delete, onConfirm: () => controller.deleteRoom(id));
  }

  static void confirmDeleteItem(InventoryController controller, String id) {
    ConfirmActionDialog.show(title: 'Delete Item', message: 'Remove this item from the checklist? This cannot be undone.', confirmLabel: ConstString.delete, onConfirm: () => controller.deleteItem(id));
  }
}