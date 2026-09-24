// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/tenant_payments_history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../controller/property_detail_controller.dart';

class TenantPaymentsHistoryScreen extends GetView<PropertyDetailController> {
  const TenantPaymentsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tenant = controller.selectedTenant.value;
      if (tenant == null) return const Scaffold(body: SizedBox.shrink());
      final h = tenant.paymentsHistory;

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.paymentsHistory),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Row(
              children: [
                Expanded(
                  child: _SummaryTile(
                    icon: Icons.credit_card_outlined,
                    label: ConstString.lastPayment,
                    value: '£${h.lastPayment.toStringAsFixed(0)}',
                    sublabel: h.lastPaymentDate,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _SummaryTile(
                    icon: Icons.calendar_month_outlined,
                    label: ConstString.nextDue,
                    value: '£${h.nextDue.toStringAsFixed(0)}',
                    sublabel: h.nextDueDate,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: _SummaryTile(
                    icon: Icons.shield_outlined,
                    label: ConstString.depositHeld,
                    value: '£${h.depositHeld.toStringAsFixed(0)}',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _SummaryTile(
                    icon: Icons.savings_outlined,
                    label: ConstString.advancePaid,
                    value: '£${h.advancePaid.toStringAsFixed(0)}',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              onPressed: () {},
              // TODO: link to Finance Record Payment flow once confirmed
              icon: Icon(Icons.add_rounded, color: Colors.white, size: 18.sp),
              child: CustomText(
                title: ConstString.recordPaymentForTenant,
                textColor: Colors.white,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            CustomText(
              title: ConstString.monthlyHistory,
              textSize: 14.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.titleColor,
            ),
            SizedBox(height: 10.h),
            if (h.stillDue.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: ConstColor.titleColor.withAlpha(30))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: ConstString.stillDue,
                      textSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      textColor: ConstColor.bodyColor,
                      letterSpacing: 0.5,
                    ),
                    SizedBox(height: 8.h),
                    ...h.stillDue.map(
                      (e) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              title: e.label,
                              textSize: 13.sp,
                              textColor: ConstColor.titleColor,
                            ),
                            CustomText(
                              title: '£${e.amount.toStringAsFixed(0)}',
                              textSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              textColor: ConstColor.errorColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
            ...h.monthly.map(
              (e) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: ConstColor.titleColor.withAlpha(30))
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: e.label,
                              textSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              textColor: ConstColor.titleColor,
                            ),
                            CustomText(
                              title: 'Due ${e.dueDateLabel}',
                              textSize: 11.sp,
                              textColor: ConstColor.bodyColor,
                            ),
                          ],
                        ),
                      ),
                      CustomText(
                        title: '£${e.amount.toStringAsFixed(0)}',
                        textSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        textColor: ConstColor.titleColor,
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.download_outlined,
                        size: 16.sp,
                        color: ConstColor.bodyColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.icon,
    required this.label,
    required this.value,
    this.sublabel,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? sublabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ConstColor.titleColor.withAlpha(30))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14.sp, color: ConstColor.primaryColor),
              SizedBox(width: 6.w),
              CustomText(
                title: label,
                textSize: 11.sp,
                textColor: ConstColor.bodyColor,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          CustomText(
            title: value,
            textSize: 15.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.titleColor,
          ),
          if (sublabel != null)
            CustomText(
              title: sublabel!,
              textSize: 10.sp,
              textColor: ConstColor.bodyColor,
            ),
        ],
      ),
    );
  }
}
