// lib/screens/UserScreen/LandlordAllScreen/Finance/add_charge_screen.dart
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

class AddChargeScreen extends GetView<FinanceController> {
  const AddChargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.addCharge),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomText(title: ConstString.chargeDetails, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
            SizedBox(height: 14.h),
            CustomDropdownField<ChargeType>(
              label: ConstString.chargeType,
              value: controller.chargeType.value,
              hintText: ConstString.selectChargeType,
              items: ChargeType.values.map((c) => DropdownMenuItem(value: c, child: CustomText(title: c.label, textSize: 14.sp))).toList(),
              onChanged: (v) => controller.chargeType.value = v,
            ),
            SizedBox(height: 14.h),
            CustomDropdownField<BilledTo>(
              label: ConstString.whoIsBilled,
              value: controller.billedTo.value,
              hintText: ConstString.whoIsBilled,
              items: BilledTo.values.map((b) => DropdownMenuItem(value: b, child: CustomText(title: b.label, textSize: 14.sp))).toList(),
              onChanged: (v) {
                controller.billedTo.value = v!;
                controller.chargeTenant.value = null;
              },
            ),
            SizedBox(height: 14.h),
            CustomDropdownField<FinancePropertyModel>(
              label: ConstString.property,
              value: controller.chargeProperty.value,
              hintText: ConstString.selectProperty,
              items: controller.financeProperties.map((p) => DropdownMenuItem(value: p, child: CustomText(title: p.name, textSize: 14.sp))).toList(),
              onChanged: (p) {
                controller.chargeProperty.value = p;
                controller.chargeUnit.value = null;
                controller.chargeTenant.value = null;
              },
            ),
            SizedBox(height: 14.h),
            CustomDropdownField<UnitOptionModel>(
              label: ConstString.unit,
              value: controller.chargeUnit.value,
              hintText: ConstString.unit,
              items: (controller.chargeProperty.value?.units ?? []).map((u) => DropdownMenuItem(value: u, child: CustomText(title: u.label, textSize: 14.sp, maxLine: 1))).toList(),
              onChanged: (u) {
                controller.chargeUnit.value = u;
                controller.chargeTenant.value = null;
              },
            ),
            if (controller.billedTo.value == BilledTo.specificTenant) ...[
              SizedBox(height: 14.h),
              CustomDropdownField<TenantOptionModel>(
                label: ConstString.tenant,
                value: controller.chargeTenant.value,
                hintText: ConstString.chooseOneTenant,
                items: (controller.chargeUnit.value?.tenants ?? []).map((t) => DropdownMenuItem(value: t, child: CustomText(title: t.name, textSize: 14.sp))).toList(),
                onChanged: (t) => controller.chargeTenant.value = t,
              ),
            ],
            SizedBox(height: 14.h),
            CustomTextFormField(
              fromTitle: ConstString.amountPounds,
              textController: controller.chargeAmountController,
              keyboardType: TextInputType.number,
              numeric: true,
              hintText: CustomText(title: '150', textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            CustomDateField(label: ConstString.dueDate, date: controller.chargeDueDate.value, onTap: () => controller.pickChargeDueDate(context)),
            SizedBox(height: 14.h),
            CustomTextFormField(
              fromTitle: ConstString.descriptionNotes,
              textController: controller.chargeDescriptionController,
              hintText: CustomText(title: ConstString.chargeForHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
              maxLine: 4,
              minLines: 4,
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              onPressed: controller.canSubmitChargeRx.value && !controller.isSubmittingCharge.value ? controller.submitCharge : null,
              child: CustomText(title: controller.isSubmittingCharge.value ? ConstString.sending : ConstString.sendCharge, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}