// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/tenant_add_note_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../controller/property_detail_controller.dart';

class TenantAddNoteScreen extends GetView<PropertyDetailController> {
  const TenantAddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.addNote),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(title: ConstString.notesHelper, textSize: 12.sp, textColor: ConstColor.bodyColor, maxLine: 2),
            SizedBox(height: 16.h),
            CustomTextFormField(
              fromTitle: ConstString.note,
              textController: controller.noteTextController,
              hintText: CustomText(title: 'Communication preferences, reminders, lease discussions...', textColor: ConstColor.bodyColor, textSize: 14.sp),
              maxLine: 6,
              minLines: 6,
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.saveNote,
              child: CustomText(title: ConstString.saveNote, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}