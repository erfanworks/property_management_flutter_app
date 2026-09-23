// lib/screens/UserScreen/LandlordAllScreen/Finance/finance_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../widget/CustomSegmentedToggle/custom_segmented_toggle.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'controller/finance_controller.dart';
import 'model/finance_summary_model.dart';

class FinanceScreen extends GetView<FinanceController> {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.finances),
      body: Obx(() {
        final summary = controller.currentSummary;
        return ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomSegmentedToggle(
              options: FinanceTab.values.map((t) => SegmentedOption(label: t.label)).toList(),
              selectedIndex: FinanceTab.values.indexOf(controller.selectedTab.value),
              onChanged: (i) => controller.selectTab(FinanceTab.values[i]),
            ),
            SizedBox(height: 16.h),
            _SummaryCard(summary: summary),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              onPressed: controller.openRecordPaymentStep1,
              icon: Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 18.sp),
              child: CustomText(title: ConstString.recordRentReceived, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: controller.openAddCharge,
                    isOutLined: true,
                    elevation: 0,
                    outLineColour: ConstColor.dividerColor,
                    icon: Icon(Icons.add_rounded, color: ConstColor.titleColor, size: 18.sp),
                    child: CustomText(title: ConstString.addCharge, textColor: ConstColor.titleColor, textSize: 13.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: controller.openPaymentReminder,
                    isOutLined: true,
                    elevation: 0,
                    outLineColour: ConstColor.dividerColor,
                    icon: Icon(Icons.notifications_none_rounded, color: ConstColor.titleColor, size: 18.sp),
                    child: CustomText(title: ConstString.remind, textColor: ConstColor.titleColor, textSize: 13.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: controller.openTransactionHistory,
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ConstColor.dividerColor),
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CustomIconBadge(icon: Icons.receipt_long_rounded, iconColor: ConstColor.primaryColor, backgroundColor: ConstColor.infoBg, size: 40, isCircle: false, borderRadius: 10),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(title: ConstString.transactionHistory, textSize: 14.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                          CustomText(title: '${summary.paidCount} ${ConstString.paidLower} · ${summary.outstandingCount} ${ConstString.outstandingLower}', textSize: 12.sp, textColor: ConstColor.bodyColor),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: ConstColor.bodyColor, size: 20.sp),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary});
  final FinanceSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ConstColor.dividerColor),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(title: ConstString.thisMonth, textSize: 11.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.5),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: '£${summary.collectedAmount.toStringAsFixed(0)}', textSize: 26.sp, fontWeight: FontWeight.w800, textColor: ConstColor.titleColor),
                  CustomText(title: 'of £${summary.expectedAmount.toStringAsFixed(0)} expected', textSize: 12.sp, textColor: ConstColor.bodyColor),
                ],
              ),
              SizedBox(
                width: 56.r,
                height: 56.r,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 56.r,
                      height: 56.r,
                      child: CircularProgressIndicator(
                        value: summary.collectedPercentage / 100,
                        strokeWidth: 5.r,
                        backgroundColor: ConstColor.dividerColor,
                        valueColor: AlwaysStoppedAnimation(ConstColor.tenantIconColor),
                      ),
                    ),
                    CustomText(title: '${summary.collectedPercentage}%', textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: summary.collectedPercentage / 100,
              minHeight: 6.h,
              backgroundColor: ConstColor.dividerColor,
              valueColor: AlwaysStoppedAnimation(ConstColor.tenantIconColor),
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: summary.stats
                .map((s) => Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 3.w), child: _StatChip(stat: s))))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.stat});
  final FinanceStatItem stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: stat.bg,
        border: Border.all(color: stat.color.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          CustomText(title: stat.value, textSize: 14.sp, fontWeight: FontWeight.w700, textColor: stat.color),
          SizedBox(height: 2.h),
          CustomText(title: stat.label, textSize: 10.sp, textColor: stat.color, maxLine: 1),
        ],
      ),
    );
  }
}