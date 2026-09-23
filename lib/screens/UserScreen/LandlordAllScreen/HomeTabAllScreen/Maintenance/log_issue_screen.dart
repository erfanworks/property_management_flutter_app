// lib/screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/log_issue_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:imusa04_landlord_app/widget/CustomSegmentedToggle/custom_segmented_toggle.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../../../../models/property_model.dart';
import 'controller/maintenance_controller.dart';
import 'model/maintenance_issue_model.dart';
import 'model/maintenance_property_model.dart';

class LogIssueScreen extends GetView<MaintenanceController> {
  const LogIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.logIssue),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomDropdownField<PropertyModel>(
              backgroundColor: Colors.white,
              label: ConstString.property,
              value: controller.formProperty.value,
              hintText: ConstString.selectProperty,
              items: controller.properties.map((p) => DropdownMenuItem(value: p, child: CustomText(title: p.name, textSize: 14.sp))).toList(),
              onChanged: (p) {
                controller.formProperty.value = p;
                controller.formUnit.value = null;
              },
            ),
            SizedBox(height: 16.h),
            CustomText(title: ConstString.location, textSize: 14.sp, fontWeight: FontWeight.w600),
            SizedBox(height: 8.h),
            CustomSegmentedToggle(
              options: [SegmentedOption(label: ConstString.unit), SegmentedOption(label: ConstString.communal)],
              selectedIndex: controller.formLocationType.value == IssueLocationType.unit ? 0 : 1,
              onChanged: (index) => controller.setLocationType(index == 0 ? IssueLocationType.unit : IssueLocationType.communal),
            ),
            SizedBox(height: 16.h),
            if (controller.formLocationType.value == IssueLocationType.unit)
              CustomDropdownField<UnitModel>(
                backgroundColor: Colors.white,
                label: ConstString.unit,
                value: controller.formUnit.value,
                hintText: ConstString.selectProperty,
                items: (controller.formProperty.value?.units ?? [])
                    .map((u) => DropdownMenuItem(value: u, child: CustomText(title: u.label, textSize: 14.sp, maxLine: 1)))
                    .toList(),
                onChanged: (u) => controller.formUnit.value = u,
              )
            else
              CustomDropdownField<String>(
                backgroundColor: Colors.white,
                label: ConstString.communalArea,
                value: controller.formCommunalArea.value,
                hintText: ConstString.communalArea,
                items: MaintenanceController.communalAreas.map((a) => DropdownMenuItem(value: a, child: CustomText(title: a, textSize: 14.sp))).toList(),
                onChanged: (a) => controller.formCommunalArea.value = a,
              ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              backgroundColor: Colors.white,
              fromTitle: ConstString.issueTitle,
              textController: controller.titleController,
              hintText: CustomText(title: ConstString.issueTitleHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            CustomDropdownField<IssueTypeModel>(
              backgroundColor: Colors.white,
              label: ConstString.issueType,
              value: controller.formIssueType.value,
              hintText: ConstString.issueType,
              items: controller.issueTypes.map((t) => DropdownMenuItem(value: t, child: CustomText(title: t.label, textSize: 14.sp, maxLine: 1))).toList(),
              onChanged: (t) => controller.formIssueType.value = t,
            ),
            SizedBox(height: 16.h),
            CustomText(title: ConstString.priority, textSize: 14.sp, fontWeight: FontWeight.w600),
            SizedBox(height: 8.h),
            CustomSegmentedToggle(
              options: [
                SegmentedOption(label: ConstString.low, dotColor: ConstColor.tenantIconColor),
                SegmentedOption(label: ConstString.medium, dotColor: ConstColor.contractorIconColor),
                SegmentedOption(label: ConstString.high, dotColor: ConstColor.errorColor),
              ],
              selectedIndex: [IssuePriority.low, IssuePriority.medium, IssuePriority.high].indexOf(controller.formPriority.value).clamp(0, 2),
              onChanged: (index) => controller.formPriority.value = [IssuePriority.low, IssuePriority.medium, IssuePriority.high][index],
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              backgroundColor: Colors.white,
              fromTitle: ConstString.description,
              textController: controller.descriptionController,
              hintText: CustomText(title: ConstString.descriptionHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
              maxLine: 4,
              minLines: 4,
            ),
            SizedBox(height: 6.h),
            CustomText(title: ConstString.photosVideosOptional, textSize: 14.sp, fontWeight: FontWeight.w600),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: controller.pickMedia,
              child: Container(
                width: double.infinity,
                height: 90.h,
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: ConstColor.bodyColor), borderRadius: BorderRadius.circular(12.r)),
                child: controller.pickedMediaPath.value != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AppImage(filePath: controller.pickedMediaPath.value, fit: BoxFit.cover),
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: GestureDetector(
                          onTap: controller.removePickedMedia,
                          child: CircleAvatar(radius: 12.r, backgroundColor: Colors.black54, child: Icon(Icons.close_rounded, size: 14.sp, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate_outlined, color: ConstColor.bodyColor, size: 24.sp),
                    SizedBox(height: 4.h),
                    CustomText(title: ConstString.addPhotosOrVideos, textSize: 12.sp, textColor: ConstColor.bodyColor),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              onPressed: controller.canSubmitRx.value && !controller.isSubmitting.value ? controller.submitLogIssue : null,
              icon: Icon(Icons.send_rounded, color: Colors.white, size: 18.sp),
              child: CustomText(
                title: controller.isSubmitting.value ? ConstString.sending : ConstString.submitIssue,
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
}