// lib/screens/UserScreen/LandlordAllScreen/SmartReminders/add_smart_reminder_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomDateField/custom_date_field.dart';
import '../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/smart_reminders_controller.dart';

class AddSmartReminderScreen extends GetView<SmartRemindersController> {
  const AddSmartReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: 'Add Smart Reminder'),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomDropdownField<String>(
              label: ConstString.smartReminderType,
              value: ConstString.customSmartReminder,
              items: [DropdownMenuItem(value: ConstString.customSmartReminder, child: CustomText(title: ConstString.customSmartReminder, textSize: 14.sp))],
              onChanged: (_) {},
            ),
            CustomTextFormField(
              fromTitle: ConstString.titleField,
              textController: controller.titleController,
              hintText: CustomText(title: ConstString.titleFieldHint, textColor: ConstColor.bodyColor, textSize: 14.sp),
            ),
            CustomDropdownField<String>(
              label: ConstString.property,
              value: controller.formProperty.value,
              hintText: ConstString.selectProperty,
              items: controller.properties.map((p) => DropdownMenuItem(value: p, child: CustomText(title: p, textSize: 14.sp))).toList(),
              onChanged: (v) => controller.formProperty.value = v,
            ),
            SizedBox(height: 10.h),
            CustomDateField(label: ConstString.dueDateField, date: controller.formDueDate.value, onTap: () => controller.pickDueDate(context)),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.isSaving.value ? null : controller.saveReminder,
              child: CustomText(title: controller.isSaving.value ? ConstString.saving : ConstString.saveSmartReminder, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}