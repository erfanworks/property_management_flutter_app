// lib/screens/UserScreen/LandlordAllScreen/Finance/payment_reminder_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'controller/finance_controller.dart';
import 'model/transaction_model.dart';

class PaymentReminderScreen extends GetView<FinanceController> {
  const PaymentReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.paymentReminder),
      body: Obx(
            () => Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.r),
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: ConstColor.infoBg,
                      border: Border.all(color: ConstColor.primaryColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CustomIconBadge(icon: Icons.notifications_none_rounded, iconColor: ConstColor.primaryColor, backgroundColor: Colors.white, size: 36),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(title: '£${controller.totalOutstandingAmount.toStringAsFixed(0)} ${ConstString.outstandingLower}', textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                              CustomText(title: '${controller.outstandingTenantCount} ${ConstString.tenantsWithDueOrOverdue}', textSize: 12.sp, textColor: ConstColor.bodyColor),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(title: ConstString.selectTenants, textSize: 14.sp, fontWeight: FontWeight.w700),
                      GestureDetector(
                        onTap: controller.selectedReminderIds.length == controller.outstandingTenantCount ? controller.clearReminderSelection : controller.selectAllReminders,
                        child: CustomText(
                          title: controller.selectedReminderIds.length == controller.outstandingTenantCount ? ConstString.none : ConstString.all,
                          textSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          textColor: ConstColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ...controller.outstandingTransactions.map(
                        (t) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: _ReminderTenantTile(data: t, isSelected: controller.selectedReminderIds.contains(t.id), onTap: () => controller.toggleReminderSelection(t.id)),
                    ),
                  ),
                  SizedBox(height: 16.h),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: ConstString.messagePreview, textSize: 14.sp, fontWeight: FontWeight.w700),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          textController: controller.reminderMessageController,
                          backgroundColor: Colors.white,
                          hintText: CustomText(title: ConstString.reminderMessageHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
                          maxLine: 3,
                          minLines: 3,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(title: ConstString.personalizedPerTenant, textSize: 11.sp, textColor: ConstColor.bodyColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: CustomElevatedButton(
                onPressed: controller.selectedReminderIds.isNotEmpty && !controller.isSendingReminder.value ? controller.sendPaymentReminder : null,
                icon: Icon(Icons.send_rounded, color: Colors.white, size: 18.sp),
                child: CustomText(title: controller.isSendingReminder.value ? ConstString.sending : ConstString.sendReminder, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderTenantTile extends StatelessWidget {
  const _ReminderTenantTile({required this.data, required this.isSelected, required this.onTap});
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
            Checkbox(
              value: isSelected,
              onChanged: (_) => onTap(),
              activeColor: ConstColor.primaryColor,
              side: BorderSide(color: ConstColor.dividerColor, width: 1.2.w),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            SizedBox(width: 4.w),
            ClipRRect(borderRadius: BorderRadius.circular(20.r), child: AppImage(url: data.tenantAvatarUrl, width: 36.r, height: 36.r, fit: BoxFit.cover)),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: data.tenantName, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                  CustomText(title: '${data.unitLabel} · ${data.propertyName}', textSize: 11.sp, textColor: ConstColor.bodyColor, maxLine: 1),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(title: '£${data.amount.toStringAsFixed(0)}', textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                CustomText(title: data.extraNoteLabel ?? data.status.label, textSize: 11.sp, fontWeight: FontWeight.w600, textColor: data.status.color),
              ],
            ),
          ],
        ),
      ),
    );
  }
}