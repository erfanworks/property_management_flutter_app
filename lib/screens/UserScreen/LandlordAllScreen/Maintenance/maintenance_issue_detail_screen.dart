// lib/screens/UserScreen/LandlordAllScreen/Maintenance/maintenance_issue_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:imusa04_landlord_app/screens/UserScreen/LandlordAllScreen/Maintenance/widget/custom_status_chip.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'controller/maintenance_controller.dart';
import 'model/maintenance_issue_model.dart';
import 'widget/contractor_tile.dart';

class MaintenanceIssueDetailScreen extends GetView<MaintenanceController> {
  const MaintenanceIssueDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.selectedIssue.value;
      if (data == null) return const SizedBox.shrink();

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.maintenanceIssue),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Row(
              children: [
                CustomStatusChip(label: '${data.priority.label} priority', color: data.priority.color, backgroundColor: data.priority.bg, icon: Icons.schedule_rounded),
                SizedBox(width: 8.w),
                CustomStatusChip(label: data.status.detailTagLabel, color: data.status.detailTagColor, backgroundColor: data.status.detailTagBg),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
              child: Row(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(24.r), child: AppImage(url: null, width: 40.r, height: 40.r, fit: BoxFit.cover)),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 12.sp, color: ConstColor.bodyColor),
                            SizedBox(width: 3.w),
                            Expanded(child: CustomText(title: '${data.propertyName}, ${data.unitLabel}', textSize: 12.sp, textColor: ConstColor.bodyColor, maxLine: 1)),
                          ],
                        ),
                        CustomText(title: data.tenantName, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                        Row(
                          children: [
                            Icon(Icons.phone_outlined, size: 11.sp, color: ConstColor.bodyColor),
                            SizedBox(width: 3.w),
                            CustomText(title: data.tenantPhone, textSize: 11.sp, textColor: ConstColor.bodyColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chat_bubble_outline_rounded, color: ConstColor.primaryColor, size: 20.sp),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(color: data.issueType.bg, borderRadius: BorderRadius.circular(20.r)),
                    child: CustomText(title: data.issueType.label, textSize: 11.sp, fontWeight: FontWeight.w600, textColor: data.issueType.color),
                  ),
                  SizedBox(height: 8.h),
                  CustomText(title: data.title, textSize: 16.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                  SizedBox(height: 2.h),
                  CustomText(title: 'Reported ${data.reportedAgoLabel} · ${data.refCode}', textSize: 11.sp, textColor: ConstColor.bodyColor),
                  SizedBox(height: 10.h),
                  CustomText(title: data.description, textSize: 13.sp, textColor: ConstColor.titleColor, maxLine: 10, textHeight: 1.4),
                  if (data.photoUrls.isNotEmpty || data.videoCount > 0) ...[
                    SizedBox(height: 14.h),
                    CustomText(title: 'Photos (${data.photoUrls.length} · ${data.videoCount} video)', textSize: 12.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                    SizedBox(height: 8.h),
                    _MediaThumbnails(photoUrls: data.photoUrls, videoCount: data.videoCount),
                  ],
                  if (data.tenantPays) ...[
                    SizedBox(height: 6.h),
                    CustomText(title: ConstString.tenantPays, textSize: 11.sp, textColor: ConstColor.bodyColor),
                  ],
                ],
              ),
            ),
            SizedBox(height: 14.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: ConstString.progress, textSize: 14.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                  SizedBox(height: 14.h),
                  _ProgressStepper(currentIndex: data.status.stepIndex),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            if (data.status == IssueStatus.open) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: ConstString.assignContractor, textSize: 14.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                  GestureDetector(
                    onTap: controller.openAssignContractor,
                    child: CustomText(title: ConstString.viewAll, textSize: 12.sp, fontWeight: FontWeight.w500, textColor: ConstColor.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              CustomText(title: '${ConstString.suggestedForPrefix} ${data.issueType.label}', textSize: 11.sp, textColor: ConstColor.bodyColor),
              SizedBox(height: 10.h),
              ...controller.contractors.take(3).map(
                    (c) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: ContractorTile(
                    data: c,
                    trailing: SizedBox(
                      height: 28.h,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: ConstColor.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        onPressed: () => controller.assignContractor(c),
                        child: CustomText(title: ConstString.assign, textColor: Colors.white, textSize: 12.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ] else if (data.assignedContractor != null) ...[
              ContractorTile(
                data: data.assignedContractor!,
                subtitle: data.visitLabel ?? ConstString.visitNotScheduled,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chat_bubble_outline_rounded, color: ConstColor.primaryColor, size: 18.sp),
                    SizedBox(width: 10.w),
                    Icon(Icons.call_outlined, color: ConstColor.primaryColor, size: 18.sp),
                  ],
                ),
              ),
            ],
            SizedBox(height: 20.h),
            Center(
              child: GestureDetector(
                onTap: controller.confirmCancelIssue,
                child: CustomText(title: ConstString.cancelIssue, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.errorColor),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _MediaThumbnails extends StatelessWidget {
  const _MediaThumbnails({required this.photoUrls, required this.videoCount});
  final List<String> photoUrls;
  final int videoCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photoUrls.length + (videoCount > 0 ? 1 : 0),
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          if (index < photoUrls.length) {
            return ClipRRect(borderRadius: BorderRadius.circular(10.r), child: AppImage(path: photoUrls[index], width: 70.w, height: 70.h, fit: BoxFit.cover));
          }
          return Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(color: ConstColor.titleColor, borderRadius: BorderRadius.circular(10.r)),
            child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24.sp),
          );
        },
      ),
    );
  }
}

class _ProgressStepper extends StatelessWidget {
  const _ProgressStepper({required this.currentIndex});
  final int currentIndex;
  static const _labels = ['Reported', 'Assigned', 'In progress', 'Done'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_labels.length, (index) {
        final isDone = index <= currentIndex;
        final isLast = index == _labels.length - 1;
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 16.r,
                    height: 16.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDone ? ConstColor.primaryColor : Colors.white,
                      border: Border.all(color: isDone ? ConstColor.primaryColor : ConstColor.dividerColor, width: 2),
                    ),
                    child: isDone ? Icon(Icons.check, size: 10.sp, color: Colors.white) : null,
                  ),
                  if (!isLast) Expanded(child: Container(height: 2.h, color: index < currentIndex ? ConstColor.primaryColor : ConstColor.dividerColor)),
                ],
              ),
              SizedBox(height: 4.h),
              CustomText(title: _labels[index], textSize: 10.sp, textColor: isDone ? ConstColor.titleColor : ConstColor.bodyColor),
            ],
          ),
        );
      }),
    );
  }
}