// lib/screens/UserScreen/LandlordAllScreen/Contractors/invite_contractor_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/contractors_controller.dart';

class InviteContractorScreen extends GetView<ContractorsController> {
  const InviteContractorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.inviteContractor),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomText(title: ConstString.sendEmailInviteHint, textSize: 12.sp, textColor: ConstColor.bodyColor, maxLine: 2),
            SizedBox(height: 14.h),
            CustomTextFormField(
              fromTitle: ConstString.companyName,
              textController: controller.companyNameController,
              hintText: CustomText(title: ConstString.companyNameHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            CustomTextFormField(
              fromTitle: ConstString.email,
              textController: controller.emailController,
              hintText: CustomText(title: 'contractor@email.com', textColor: ConstColor.bodyColor, textSize: 14.sp),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: ConstString.tradeField, textSize: 14.sp, fontWeight: FontWeight.w600),
                CustomText(title: ConstString.selectMultipleIfApplicable, textSize: 11.sp, textColor: ConstColor.bodyColor),
              ],
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: ContractorsController.tradeOptions.map((trade) {
                final isSelected = controller.selectedTrades.contains(trade);
                return GestureDetector(
                  onTap: () => controller.toggleTrade(trade),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(color: isSelected ? ConstColor.primaryColor : Colors.white, borderRadius: BorderRadius.circular(20.r), border: Border.all(color: isSelected ? ConstColor.primaryColor : ConstColor.dividerColor)),
                    child: CustomText(title: trade, textSize: 12.sp, fontWeight: FontWeight.w600, textColor: isSelected ? Colors.white : ConstColor.titleColor),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              onPressed: controller.isSendingInvite.value ? null : controller.sendInvite,
              child: CustomText(title: ConstString.sendInvite, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}