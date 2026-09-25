// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/conduct_inspection_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/inspections_controller.dart';
import 'model/inspection_model.dart';

class ConductInspectionScreen extends GetView<InspectionsController> {
  const ConductInspectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: 'Conduct Inspection'),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomDropdownField<String>(
              label: 'SELECT FLAT / AREA',
              value: controller.selectedArea.value,
              items: controller.areaOptions.map((a) => DropdownMenuItem(value: a, child: CustomText(title: a, textSize: 14.sp))).toList(),
              onChanged: controller.selectArea,
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(title: 'ROOM CHECKLIST', textSize: 10.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.4),
                          CustomText(title: '${controller.checkedCount} of ${controller.checklist.length} Checked', textSize: 11.sp, textColor: ConstColor.bodyColor),
                        ],
                      ),
                      GestureDetector(onTap: controller.markAllPass, child: CustomText(title: 'Mark All Pass', textSize: 12.sp, fontWeight: FontWeight.w600, textColor: ConstColor.contractorIconColor)),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ...controller.checklist.map((room) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      children: [
                        Icon(room.icon, size: 18.sp, color: ConstColor.bodyColor),
                        SizedBox(width: 8.w),
                        Expanded(child: CustomText(title: room.roomName, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor)),
                        _StatusPill(label: 'Pass', isSelected: room.status == RoomCheckStatus.pass, color: ConstColor.tenantIconColor, onTap: () => controller.setRoomStatus(room.roomName, RoomCheckStatus.pass)),
                        SizedBox(width: 6.w),
                        _StatusPill(label: 'Fair', isSelected: room.status == RoomCheckStatus.fair, color: ConstColor.contractorIconColor, onTap: () => controller.setRoomStatus(room.roomName, RoomCheckStatus.fair)),
                        SizedBox(width: 6.w),
                        _StatusPill(label: 'Defect', isSelected: room.status == RoomCheckStatus.defect, color: ConstColor.errorColor, onTap: () => controller.setRoomStatus(room.roomName, RoomCheckStatus.defect)),
                      ],
                    ),
                  )),
                  if (controller.hasDefect)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(color: ConstColor.errorBg, borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        children: [
                          Expanded(child: CustomText(title: 'Defect flagged', textSize: 12.sp, fontWeight: FontWeight.w600, textColor: ConstColor.errorColor)),
                          GestureDetector(
                            onTap: () {
                              final defectRoom = controller.checklist.firstWhere((r) => r.status == RoomCheckStatus.defect);
                              controller.logRepairForDefect(defectRoom.roomName);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(color: ConstColor.errorColor, borderRadius: BorderRadius.circular(20.r)),
                              child: CustomText(title: '+ Log Repair', textSize: 11.sp, fontWeight: FontWeight.w600, textColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(title: 'PHOTOS & NOTES', textSize: 10.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.4),
                      CustomText(title: '${controller.attachedPhotos.length} attached', textSize: 11.sp, textColor: ConstColor.bodyColor),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: controller.addPhotoPlaceholder,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(border: Border.all(color: ConstColor.dividerColor), borderRadius: BorderRadius.circular(20.r)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.camera_alt_outlined, size: 14.sp, color: ConstColor.primaryColor), SizedBox(width: 6.w), CustomText(title: 'Add Photo', textSize: 12.sp, fontWeight: FontWeight.w600, textColor: ConstColor.primaryColor)]),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    fromTitle: 'Notes',
                    textController: controller.notesController,
                    hintText: CustomText(title: 'Record inspector observations or tenant feedback...', textColor: ConstColor.bodyColor, textSize: 14.sp),
                    maxLine: 3,
                    minLines: 3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.saveInspectionReport,
              icon: Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 18.sp),
              child: CustomText(title: 'Save Inspection Report', textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.isSelected, required this.color, required this.onTap});
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(color: isSelected ? color.withAlpha(30) : Colors.white, border: Border.all(color: isSelected ? color : ConstColor.dividerColor), borderRadius: BorderRadius.circular(20.r)),
        child: CustomText(title: label, textSize: 11.sp, fontWeight: FontWeight.w600, textColor: isSelected ? color : ConstColor.bodyColor),
      ),
    );
  }
}