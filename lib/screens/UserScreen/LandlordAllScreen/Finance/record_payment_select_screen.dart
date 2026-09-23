import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'controller/finance_controller.dart';
import 'model/transaction_model.dart';
import 'widget/finance_summary_stat.dart';

class RecordPaymentSelectScreen extends GetView<FinanceController> {
  const RecordPaymentSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.recordPayment),
      body: Obx(() {
        final grouped = controller.outstandingByProperty;
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: ConstColor.dividerColor)),
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
                  Expanded(child: FinanceSummaryStat(label: ConstString.selected, value: '£${controller.selectedPaymentTotal.toStringAsFixed(0)}', color: ConstColor.tenantIconColor)),
                  Expanded(child: FinanceSummaryStat(label: ConstString.outstanding, value: '£${controller.totalOutstandingAmount.toStringAsFixed(0)}', color: ConstColor.contractorIconColor)),
                  Expanded(child: FinanceSummaryStat(label: ConstString.due, value: '${controller.selectedPaymentIds.length} ${ConstString.ofPrefix} ${controller.outstandingTenantCount}', color: ConstColor.titleColor)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: ConstString.selectPayments, textSize: 14.sp, fontWeight: FontWeight.w700),
                  GestureDetector(
                    onTap: controller.selectedPaymentIds.length == controller.outstandingTenantCount ? controller.clearPaymentSelection : controller.selectAllOutstandingForPayment,
                    child: CustomText(title: ConstString.all, textSize: 13.sp, fontWeight: FontWeight.w500, textColor: ConstColor.primaryColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: grouped.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(title: entry.key, textSize: 12.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                            CustomText(title: '${entry.value.length} ${ConstString.dueLower}', textSize: 11.sp, textColor: ConstColor.bodyColor),
                          ],
                        ),
                      ),
                      ...entry.value.map(
                            (t) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: _PaymentSelectTile(data: t, isSelected: controller.selectedPaymentIds.contains(t.id), onTap: () => controller.togglePaymentSelection(t.id)),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: CustomElevatedButton(
                onPressed: controller.selectedPaymentIds.isNotEmpty ? controller.proceedToPaymentDetails : null,
                child: CustomText(title: ConstString.recordPayment, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _PaymentSelectTile extends StatelessWidget {
  const _PaymentSelectTile({required this.data, required this.isSelected, required this.onTap});
  final TransactionModel data;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isSelected ? ConstColor.primaryColor.withAlpha(12) : Colors.white,
          border: Border.all(
            color: isSelected ? ConstColor.primaryColor.withAlpha(180) : ConstColor.dividerColor,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: data.tenantName, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                  CustomText(title: '${data.unitLabel} · ${data.typeLabel} · ${data.dueDateLabel}', textSize: 11.sp, textColor: ConstColor.bodyColor, maxLine: 1),
                  if (data.status == TransactionStatus.overdue) CustomText(title: data.extraNoteLabel ?? '', textSize: 11.sp, fontWeight: FontWeight.w600, textColor: ConstColor.errorColor),
                ],
              ),
            ),
            CustomText(title: '£${data.amount.toStringAsFixed(0)}', textSize: 14.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
            SizedBox(width: 8.w),
            Checkbox(
              value: isSelected,
              onChanged: (_) => onTap(),
              activeColor: ConstColor.primaryColor,
              side: BorderSide(color: ConstColor.dividerColor, width: 1.2.w),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}