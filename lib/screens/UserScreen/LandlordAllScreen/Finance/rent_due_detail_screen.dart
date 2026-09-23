// lib/screens/UserScreen/LandlordAllScreen/Finance/rent_due_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomStatusChip/custom_status_chip.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'controller/finance_controller.dart';
import 'model/transaction_model.dart';
import 'payment_record_detail_screen.dart';

class RentDueDetailScreen extends GetView<FinanceController> {
  const RentDueDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.selectedTransaction.value;
      if (data == null) return const SizedBox.shrink();

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.rentDue),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24.h),
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
                children: [
                  CustomText(
                    title: ConstString.amountDue,
                    textSize: 12.sp,
                    textColor: ConstColor.bodyColor,
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    title: '£${data.amount.toStringAsFixed(0)}',
                    textSize: 30.sp,
                    fontWeight: FontWeight.w800,
                    textColor: data.status.color,
                  ),
                  SizedBox(height: 8.h),
                  CustomStatusChip(
                    label: data.status.label,
                    color: data.status.color,
                    backgroundColor: data.status.bg,
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    title: data.dueDateLabel,
                    textSize: 12.sp,
                    textColor: ConstColor.bodyColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
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
                children: [
                  DetailRow(label: ConstString.tenant, value: data.tenantName),
                  DetailRow(
                    label: ConstString.property,
                    value: data.propertyName,
                  ),
                  DetailRow(label: ConstString.unit, value: data.unitLabel),
                  DetailRow(
                    label: ConstString.type,
                    value:
                        '${data.dueDateLabel} ${data.typeLabel.toLowerCase()}',
                  ),
                  DetailRow(
                    label: ConstString.dueDate,
                    value: data.dueDateLabel,
                  ),
                  DetailRow(
                    label: ConstString.invoiceHash,
                    value: data.invoiceNumber,
                    isLast: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: () => controller.startSingleRecordPayment(data),
              child: CustomText(
                title: ConstString.recordPayment,
                textColor: Colors.white,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () => controller.downloadRentDuePdf(data),
                    isOutLined: true,
                    outLineColour: ConstColor.dividerColor,
                    elevation: 0,
                    child: CustomText(
                      title: ConstString.downloadPdf,
                      textColor: ConstColor.titleColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {},
                    isOutLined: true,
                    elevation: 0,
                    outLineColour: ConstColor.dividerColor,
                    child: CustomText(
                      title: ConstString.viewRentPayments,
                      textColor: ConstColor.titleColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            CustomElevatedButton(
              onPressed: () => controller.cancelBill(data.id),
              color: ConstColor.errorColor.withAlpha(5),
              borderColor: ConstColor.errorColor,
              elevation: 0,
              child: CustomText(
                title: ConstString.cancelBill,
                textSize: 13.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.errorColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}
