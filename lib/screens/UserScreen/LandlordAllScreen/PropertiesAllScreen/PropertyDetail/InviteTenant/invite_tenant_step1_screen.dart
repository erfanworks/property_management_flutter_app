// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/invite_tenant_step1_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../models/property_model.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../controller/property_detail_controller.dart';

class InviteTenantStep1Screen extends GetView<PropertyDetailController> {
  const InviteTenantStep1Screen({super.key});

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
            const StepProgressForInvite(step: 1),
            SizedBox(height: 16.h),
            CustomDropdownField<UnitModel>(
              label: ConstString.selectFlat,
              value: controller.inviteUnit.value,
              hintText: ConstString.selectFlat,
              items: (property?.units ?? [])
                  .map(
                    (u) => DropdownMenuItem(
                      value: u,
                      child: CustomText(title: u.label, textSize: 14.sp),
                    ),
                  )
                  .toList(),
              onChanged: (u) => controller.inviteUnit.value = u,
            ),
            CustomTextFormField(
              fromTitle: ConstString.emailAddressLabel,
              textController: controller.inviteEmailController,
              hintText: CustomText(
                title: 'name@email.com',
                textColor: ConstColor.bodyColor,
                textSize: 14.sp,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextFormField(
              fromTitle: ConstString.personalMessage,
              textController: controller.invitePersonalMessageController,
              hintText: CustomText(
                title: ConstString.personalMessageHint,
                textColor: ConstColor.bodyColor,
                textSize: 14.sp,
              ),
              maxLine: 3,
              minLines: 3,
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.canProceedInviteStep1
                  ? controller.goToInviteStep2
                  : null,
              child: CustomText(
                title: ConstString.continueLabel,
                textColor: Colors.white,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PropertyHeaderForInvite extends StatelessWidget {
  const PropertyHeaderForInvite({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ConstColor.titleColor.withAlpha(30))
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: property.photoUrls.isNotEmpty
                ? AppImage(
                    path: property.photoUrls.first,
                    width: 56.r,
                    height: 56.r,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 56.r,
                    height: 56.r,
                    color: ConstColor.dividerColor,
                  ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: property.name,
                textSize: 13.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.titleColor,
              ),
              CustomText(
                title: property.address ?? '',
                textSize: 11.sp,
                textColor: ConstColor.bodyColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StepProgressForInvite extends StatelessWidget {
  const StepProgressForInvite({super.key, required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == 2 ? 0 : 4.w),
            height: 4.h,
            decoration: BoxDecoration(
              color: index < step
                  ? ConstColor.primaryColor
                  : ConstColor.dividerColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),
      ),
    );
  }
}
