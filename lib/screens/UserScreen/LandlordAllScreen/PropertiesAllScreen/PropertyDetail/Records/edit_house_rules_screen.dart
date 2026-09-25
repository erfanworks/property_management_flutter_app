// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/edit_house_rules_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/house_rules_controller.dart';

class EditHouseRulesScreen extends GetView<HouseRulesController> {
  const EditHouseRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: 'Edit House Rules'),
      body: Column(
        children: [
          QuillSimpleToolbar(controller: controller.quillController),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16.r),
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
              child: QuillEditor.basic(controller: controller.quillController),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: CustomElevatedButton(
              onPressed: controller.saveRules,
              child: CustomText(title: 'Save Changes', textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}