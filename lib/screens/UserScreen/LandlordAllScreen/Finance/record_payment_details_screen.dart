// lib/screens/UserScreen/LandlordAllScreen/Finance/record_payment_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomDateField/custom_date_field.dart';
import '../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'controller/finance_controller.dart';
import 'model/finance_reference_model.dart';
import 'widget/finance_summary_stat.dart';

class RecordPaymentDetailsScreen extends GetView<FinanceController> {
  const RecordPaymentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.recordPayment),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
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
                  Expanded(child: FinanceSummaryStat(label: ConstString.selected, value: '£${controller.selectedPaymentTotal.toStringAsFixed(0)}', color: ConstColor.tenantIconColor)),
                  Expanded(child: FinanceSummaryStat(label: ConstString.outstanding, value: '£${controller.totalOutstandingAmount.toStringAsFixed(0)}', color: ConstColor.contractorIconColor)),
                  Expanded(child: FinanceSummaryStat(label: ConstString.due, value: '${controller.selectedPaymentIds.length} ${ConstString.ofPrefix} ${controller.outstandingTenantCount}', color: ConstColor.titleColor)),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            CustomText(title: ConstString.selectPayments, textSize: 14.sp, fontWeight: FontWeight.w700),
            SizedBox(height: 8.h),
            ...controller.selectedPaymentTransactions.map(
                  (t) => Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ConstColor.primaryColor),
                  borderRadius: BorderRadius.circular(12.r),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(title: t.tenantName, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                          CustomText(title: '${t.unitLabel} · ${t.typeLabel} · Due ${t.dueDateLabel}', textSize: 11.sp, textColor: ConstColor.bodyColor, maxLine: 1),
                        ],
                      ),
                    ),
                    CustomText(title: '£${t.amount.toStringAsFixed(0)}', textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                    SizedBox(width: 8.w),
                    GestureDetector(onTap: () => controller.togglePaymentSelection(t.id), child: Icon(Icons.close_rounded, size: 16.sp, color: ConstColor.bodyColor)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(child: CustomDateField(label: ConstString.paymentReceivedOn, date: controller.paymentReceivedOn.value, backgroundColor: Colors.white, onTap: () => controller.pickPaymentReceivedDate(context))),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomDropdownField<PaymentMethod>(
                    label: ConstString.paymentMethod,
                    value: controller.paymentMethod.value,
                    hintText: ConstString.paymentMethod,
                    backgroundColor: Colors.white,
                    items: PaymentMethod.values.map((m) => DropdownMenuItem(value: m, child: CustomText(title: m.label, textSize: 14.sp))).toList(),
                    onChanged: (m) => controller.paymentMethod.value = m!,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTextFormField(
                    fromTitle: ConstString.referenceOptional,
                    textController: controller.paymentReferenceController,
                    backgroundColor: Colors.white,
                    hintText: CustomText(title: ConstString.referenceHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomTextFormField(
                    fromTitle: ConstString.amountReceivedOptional,
                    textController: controller.paymentAmountReceivedController,
                    backgroundColor: Colors.white,
                    keyboardType: TextInputType.number,
                    numeric: true,
                  ),
                ),
              ],
            ),
            CustomTextFormField(
              fromTitle: ConstString.notesOptional,
              textController: controller.paymentNotesController,
              backgroundColor: Colors.white,
              hintText: CustomText(title: ConstString.paymentNotesHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
              maxLine: 3,
              minLines: 3,
            ),
            Row(
              children: [
                Checkbox(value: controller.receiptSentToTenant.value, onChanged: (v) => controller.receiptSentToTenant.value = v ?? false, activeColor: ConstColor.primaryColor),
                CustomText(title: ConstString.receiptSentToTenant, textSize: 13.sp, textColor: ConstColor.titleColor),
              ],
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.canSubmitPayment && !controller.isSubmittingPayment.value ? controller.submitRecordPayment : null,
              child: CustomText(
                title: controller.isSubmittingPayment.value ? ConstString.sending : '${ConstString.recordPayment} · £${controller.selectedPaymentTotal.toStringAsFixed(0)}',
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