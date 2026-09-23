import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/announcement_controller.dart';
import 'model/announcement_model.dart';

class AnnouncementListScreen extends GetView<AnnouncementController> {
  const AnnouncementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.announcements),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            CustomElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.createAnnouncementScreen),
              icon: Icon(Icons.add_rounded, color: Colors.white, size: 20.sp),
              child: CustomText(title: ConstString.sendAnnouncement, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(
                    () => controller.announcements.isEmpty
                    ? Center(child: CustomText(title: ConstString.noAnnouncementsYet, textColor: ConstColor.bodyColor))
                    : ListView.separated(
                  itemCount: controller.announcements.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) => _AnnouncementTile(
                    data: controller.announcements[index],
                    onTap: () => controller.openDetail(controller.announcements[index]),
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

class _AnnouncementTile extends StatelessWidget {
  const _AnnouncementTile({required this.data, required this.onTap});
  final AnnouncementModel data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          children: [
            data.imageUrl != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: AppImage(path: data.imageUrl, width: 44.r, height: 44.r, fit: BoxFit.cover),
            )
                : CustomIconBadge(
              icon: Icons.campaign_rounded,
              iconColor: ConstColor.contractorIconColor,
              backgroundColor: ConstColor.contractorIconBg,
              size: 44,
              isCircle: false,
              borderRadius: 10,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: data.title, textSize: 14.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor, maxLine: 1),
                  SizedBox(height: 2.h),
                  CustomText(title: data.dateTimeLabel, textSize: 12.sp, textColor: ConstColor.bodyColor, maxLine: 1),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: ConstColor.bodyColor, size: 20.sp),
          ],
        ),
      ),
    );
  }
}