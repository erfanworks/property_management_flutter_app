// lib/screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Announcement/announcement_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/ConfirmActionDialog/confirm_action_dialog.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/announcement_controller.dart';

class AnnouncementDetailScreen extends GetView<AnnouncementController> {
  const AnnouncementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.selectedAnnouncement.value;
      if (data == null) return const SizedBox.shrink();

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.announcements),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            if (data.imageUrl != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: AppImage(path: data.imageUrl, width: double.infinity, height: 160.h, fit: BoxFit.cover),
              ),
              SizedBox(height: 14.h),
            ],
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomIconBadge(icon: Icons.campaign_rounded, iconColor: ConstColor.purpleColor, backgroundColor: ConstColor.purpleBg, size: 36, isCircle: false, borderRadius: 10),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(title: data.title, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor, maxLine: 2),
                            SizedBox(height: 4.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                              decoration: BoxDecoration(color: ConstColor.infoBg, borderRadius: BorderRadius.circular(20.r)),
                              child: CustomText(title: data.propertyName, textSize: 11.sp, fontWeight: FontWeight.w600, textColor: ConstColor.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(color: ConstColor.screenBackground, borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.apartment_rounded, size: 13.sp, color: ConstColor.bodyColor),
                            SizedBox(width: 4.w),
                            CustomText(title: ConstString.sentTo, textSize: 10.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.5),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        CustomText(title: data.sentToLabel, textSize: 13.sp, fontWeight: FontWeight.w500, textColor: ConstColor.titleColor),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  CustomText(title: data.message, textSize: 13.sp, textColor: ConstColor.titleColor, maxLine: 20, textHeight: 1.4),
                  SizedBox(height: 14.h),
                  Divider(color: ConstColor.dividerColor),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 13.sp, color: ConstColor.bodyColor),
                      SizedBox(width: 6.w),
                      CustomText(title: data.dateTimeLabel, textSize: 12.sp, textColor: ConstColor.bodyColor),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              elevation: 0,
              onPressed: () => ConfirmActionDialog.show(
                title: ConstString.deleteAnnouncementTitle,
                message: ConstString.deleteAnnouncementMessage,
                confirmLabel: ConstString.delete,
                onConfirm: () => controller.deleteAnnouncement(data.id),
              ),
              isOutLined: true,
              outLineColour: ConstColor.errorColor,
              icon: Icon(Icons.delete_outline_rounded, color: ConstColor.errorColor, size: 18.sp),
              child: CustomText(title: ConstString.deleteAnnouncementTitle, textColor: ConstColor.errorColor, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    });
  }
}