// lib/screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/transaction_history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../../widget/CustomSegmentedToggle/custom_segmented_toggle.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/finance_controller.dart';
import 'model/transaction_model.dart';

class TransactionHistoryScreen extends GetView<FinanceController> {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.transactionHistory),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Obx(() => CustomSegmentedToggle(
              options: [SegmentedOption(label: ConstString.outstanding), SegmentedOption(label: ConstString.paid)],
              selectedIndex: controller.showPaidTab.value ? 1 : 0,
              onChanged: (i) => controller.selectHistoryTab(i == 1),
            )),
            SizedBox(height: 14.h),
            Expanded(
              child: Obx(() {
                final list = controller.historyFilteredTransactions;
                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) => _TransactionTile(data: list[index], onTap: () => controller.openTransactionDetail(list[index])),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.data, required this.onTap});
  final TransactionModel data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ConstColor.dividerColor),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CustomIconBadge(
              icon: data.status == TransactionStatus.paid ? Icons.check_circle_outline_rounded : Icons.schedule_rounded,
              iconColor: data.status.color,
              backgroundColor: data.status.bg,
              size: 36,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: data.tenantName, textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor, maxLine: 1),
                  SizedBox(height: 2.h),
                  CustomText(title: '${data.unitLabel} · ${data.propertyName} · ${data.dueDateLabel}', textSize: 11.sp, textColor: ConstColor.bodyColor, maxLine: 1),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(title: '£${data.amount.toStringAsFixed(0)}', textSize: 14.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                SizedBox(height: 2.h),
                CustomText(
                  title: data.status == TransactionStatus.paid ? ConstString.paid : (data.extraNoteLabel ?? data.status.label),
                  textSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  textColor: data.status.color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}