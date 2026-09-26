// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/invite_tenant_step3_screen.dart
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
import '../model/property_detail_model.dart';
import '../../../../../../widget/DetailRow/detail_row.dart';
import 'invite_tenant_step1_screen.dart';

class InviteTenantStep3Screen extends GetView<PropertyDetailController> {
  const InviteTenantStep3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final property = controller.property.value;
      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.inviteTenant),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            if (property != null) PropertyHeaderForInvite(property: property),
            SizedBox(height: 14.h),
            const StepProgressForInvite(step: 3),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                children: [
                  DetailRow(label: ConstString.inviteEmail, value: controller.inviteEmailController.text),
                  DetailRow(label: ConstString.selectFlat.replaceAll('Select ', ''), value: controller.inviteUnit.value?.label ?? '-'),
                  DetailRow(label: ConstString.rentLabel, value: '£${controller.flatRentController.text}'),
                  DetailRow(label: ConstString.lease, value: '${controller.leaseStartDate.value != null ? _fmt(controller.leaseStartDate.value!) : '-'} → ${controller.leaseEndDate.value != null ? _fmt(controller.leaseEndDate.value!) : '-'}'),
                  DetailRow(label: ConstString.securityDeposit, value: '£${controller.securityDepositController.text}'),
                  DetailRow(label: ConstString.depositScheme, value: controller.inviteDepositScheme.value?.label ?? '-'),
                  DetailRow(label: ConstString.protectionRef, value: controller.protectionReferenceController.text.isEmpty ? '-' : controller.protectionReferenceController.text),
                  DetailRow(label: ConstString.messageLabel, value: controller.invitePersonalMessageController.text.isEmpty ? '-' : controller.invitePersonalMessageController.text, isLast: true),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.isSendingInvite.value ? null : controller.sendInvitation,
              icon: Icon(Icons.send_rounded, color: Colors.white, size: 18.sp),
              child: CustomText(title: controller.isSendingInvite.value ? ConstString.sending : ConstString.sendInvitation, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    });
  }

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';
}
