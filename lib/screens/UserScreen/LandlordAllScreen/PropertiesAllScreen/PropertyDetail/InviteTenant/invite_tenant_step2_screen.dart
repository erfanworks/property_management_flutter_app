// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/invite_tenant_step2_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomDateField/custom_date_field.dart';
import '../../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../controller/property_detail_controller.dart';
import '../model/property_detail_model.dart';
import 'invite_tenant_step1_screen.dart';

class InviteTenantStep2Screen extends GetView<PropertyDetailController> {
  const InviteTenantStep2Screen({super.key});

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
            const StepProgressForInvite(step: 2),
            SizedBox(height: 16.h),
            CustomTextFormField(
              fromTitle: ConstString.flatRent,
              textController: controller.flatRentController,
              keyboardType: TextInputType.number,
              numeric: true,
              hintText: CustomText(title: '£1,400', textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            Row(
              children: [
                Expanded(child: CustomDateField(label: ConstString.leaseStart, date: controller.leaseStartDate.value, onTap: () => controller.pickLeaseDate(context, controller.leaseStartDate))),
                SizedBox(width: 12.w),
                Expanded(child: CustomDateField(label: ConstString.leaseEnd, date: controller.leaseEndDate.value, onTap: () => controller.pickLeaseDate(context, controller.leaseEndDate))),
              ],
            ),
            SizedBox(height: 10.h),
            CustomText(title: ConstString.depositAndPayments, textSize: 14.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
            SizedBox(height: 10.h),
            CustomTextFormField(
              fromTitle: ConstString.securityDepositLabel,
              textController: controller.securityDepositController,
              keyboardType: TextInputType.number,
              numeric: true,
            ),
            CustomTextFormField(
              fromTitle: ConstString.advanceRentLabel,
              textController: controller.advanceRentController,
              keyboardType: TextInputType.number,
              numeric: true,
            ),
            CustomDropdownField<DepositScheme>(
              label: ConstString.depositProtectionScheme,
              value: controller.inviteDepositScheme.value,
              hintText: ConstString.depositProtectionScheme,
              items: DepositScheme.values.map((s) => DropdownMenuItem(value: s, child: CustomText(title: s.label, textSize: 14.sp))).toList(),
              onChanged: (v) => controller.inviteDepositScheme.value = v,
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              fromTitle: ConstString.protectionReference,
              textController: controller.protectionReferenceController,
              hintText: CustomText(title: ConstString.protectionReferenceHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.canProceedInviteStep2 ? controller.goToInviteStep3 : null,
              child: CustomText(title: ConstString.continueLabel, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    });
  }
}
