// lib/screens/UserScreen/LandlordAllScreen/Announcement/create_announcement_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import 'package:get/get.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'controller/announcement_controller.dart';
import 'model/announcement_model.dart';
import 'model/property_model.dart';

class CreateAnnouncementScreen extends GetView<AnnouncementController> {
  const CreateAnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.createAnnouncement),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomDropdownField<PropertyModel>(
              label: ConstString.property,
              labelIcon: Icons.apartment_rounded,
              backgroundColor: Colors.white,
              value: controller.selectedProperty.value,
              hintText: ConstString.selectProperty,
              items: controller.properties
                  .map((p) => DropdownMenuItem(value: p, child: CustomText(title: p.name, textSize: 14.sp)))
                  .toList(),
              onChanged: controller.selectProperty,
            ),
            SizedBox(height: 16.h),
            CustomText(title: ConstString.whoShouldSeeThis, textSize: 14.sp, fontWeight: FontWeight.w600),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: _AudienceOptionCard(
                    icon: Icons.apartment_rounded,
                    label: ConstString.entireProperty,
                    isSelected: controller.audience.value == AnnouncementAudience.entireProperty,
                    onTap: () => controller.setAudience(AnnouncementAudience.entireProperty),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _AudienceOptionCard(
                    icon: Icons.grid_view_rounded,
                    label: ConstString.selectedFlats,
                    isSelected: controller.audience.value == AnnouncementAudience.selectedFlats,
                    onTap: () => controller.setAudience(AnnouncementAudience.selectedFlats),
                  ),
                ),
              ],
            ),
            if (controller.audience.value == AnnouncementAudience.selectedFlats &&
                controller.selectedProperty.value != null) ...[
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: ConstString.flats, textSize: 14.sp, fontWeight: FontWeight.w600),
                  GestureDetector(
                    onTap: controller.toggleAllFlats,
                    child: Row(
                      children: [
                        CustomText(title: ConstString.allFlats, textSize: 12.sp, fontWeight: FontWeight.w500, textColor: ConstColor.primaryColor),
                        SizedBox(width: 4.w),
                        Checkbox(
                          value: controller.allFlatsSelected,
                          onChanged: (_) => controller.toggleAllFlats(),
                          activeColor: ConstColor.primaryColor,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              ...controller.selectedProperty.value!.flats.map(
                    (flat) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: _FlatSelectableTile(
                    data: flat,
                    isSelected: controller.selectedFlatIds.contains(flat.id),
                    onTap: () => controller.toggleFlat(flat.id),
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              CustomText(title: ConstString.selectedFlatsHint, textSize: 11.sp, textColor: ConstColor.bodyColor),
            ],
            SizedBox(height: 16.h),
            CustomTextFormField(
              fromTitle: ConstString.noticeTitle,
              backgroundColor: Colors.white,
              textController: controller.titleController,
              hintText: CustomText(title: ConstString.noticeTitleHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            CustomTextFormField(
              fromTitle: ConstString.message,
              backgroundColor: Colors.white,
              textController: controller.messageController,
              hintText: CustomText(title: ConstString.messageHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
              maxLine: 4,
              minLines: 4,
            ),
            SizedBox(height: 6.h),
            CustomText(title: ConstString.noticeImageOptional, textSize: 14.sp, fontWeight: FontWeight.w600),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: controller.pickImage,
              child: Container(
                width: double.infinity,
                height: 90.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ConstColor.bodyColor),
                    borderRadius: BorderRadius.circular(12.r)),
                child: controller.pickedImagePath.value != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AppImage(filePath: controller.pickedImagePath.value, fit: BoxFit.cover),
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: GestureDetector(
                          onTap: controller.removePickedImage,
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
                    CustomText(title: ConstString.addPhoto, textSize: 12.sp, textColor: ConstColor.bodyColor),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              onPressed: controller.canSendRx.value && !controller.isSending.value ? controller.sendAnnouncement : null,
              icon: Icon(Icons.send_rounded, color: Colors.white, size: 18.sp),
              child: CustomText(
                title: controller.isSending.value ? ConstString.sending : ConstString.sendNow,
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

class _AudienceOptionCard extends StatelessWidget {
  const _AudienceOptionCard({required this.icon, required this.label, required this.isSelected, required this.onTap});
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? ConstColor.infoBg : Colors.white,
          border: Border.all(color: isSelected ? ConstColor.primaryColor : ConstColor.dividerColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20.sp, color: isSelected ? ConstColor.primaryColor : ConstColor.bodyColor),
            SizedBox(height: 6.h),
            CustomText(title: label, textSize: 12.sp, fontWeight: FontWeight.w600, textColor: isSelected ? ConstColor.primaryColor : ConstColor.titleColor),
          ],
        ),
      ),
    );
  }
}

class _FlatSelectableTile extends StatelessWidget {
  const _FlatSelectableTile({required this.data, required this.isSelected, required this.onTap});
  final FlatModel data;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: isSelected ? ConstColor.primaryColor : ConstColor.dividerColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Checkbox(value: isSelected, onChanged: (_) => onTap(), activeColor: ConstColor.primaryColor, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
            SizedBox(width: 4.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: AppImage(url: data.tenantAvatarUrl, width: 32.r, height: 32.r, fit: BoxFit.cover),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: data.name, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                  CustomText(title: data.statusLabel, textSize: 11.sp, textColor: ConstColor.bodyColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}