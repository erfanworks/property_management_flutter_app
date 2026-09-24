// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/tenant_deposit_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../../../HomeTabAllScreen/Finance/payment_record_detail_screen.dart';
import '../controller/property_detail_controller.dart';

class TenantDepositScreen extends GetView<PropertyDetailController> {
  const TenantDepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tenant = controller.selectedTenant.value;
      if (tenant == null) return const Scaffold(body: SizedBox.shrink());
      final d = tenant.deposit;

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.deposit),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: ConstColor.titleColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: 'RENT, CHARGES & DEPOSIT',
                    textSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.bodyColor,
                    letterSpacing: 0.4,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: ConstString.monthlyRent,
                              textSize: 11.sp,
                              textColor: ConstColor.bodyColor,
                            ),
                            CustomText(
                              title: '£${d.monthlyRent.toStringAsFixed(0)}/mo',
                              textSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              textColor: ConstColor.titleColor,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: ConstString.dueCharges,
                              textSize: 11.sp,
                              textColor: ConstColor.bodyColor,
                            ),
                            CustomText(
                              title: '£${d.dueCharges.toStringAsFixed(0)}',
                              textSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              textColor: ConstColor.errorColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    title:
                        '${ConstString.nextMonth}: £${d.nextMonthAmount.toStringAsFixed(0)} · ${d.nextMonthLabel}',
                    textSize: 12.sp,
                    textColor: ConstColor.bodyColor,
                  ),
                  SizedBox(height: 14.h),
                  Divider(color: ConstColor.dividerColor),
                  DetailRow(
                    label: ConstString.deposit,
                    value: '£${d.depositAmount.toStringAsFixed(0)}',
                  ),
                  DetailRow(label: ConstString.moveIn, value: d.moveInDate),
                  DetailRow(label: ConstString.scheme, value: d.scheme),
                  DetailRow(
                    label: ConstString.leaseEnds,
                    value: d.leaseEndsDate,
                    isLast: true,
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: GestureDetector(
                      onTap: controller.openPaymentsHistory,
                      child: CustomText(
                        title: ConstString.viewPaymentsHistory,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        textColor: ConstColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
