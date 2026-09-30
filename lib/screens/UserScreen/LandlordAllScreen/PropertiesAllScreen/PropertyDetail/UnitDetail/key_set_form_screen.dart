// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/key_set_form_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/unit_detail_controller.dart';

class KeySetFormScreen extends GetView<UnitDetailController> {
  const KeySetFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isEdit = controller.editingKeySet.value != null;
      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: isEdit ? 'Edit Key Set' : 'Add Key Set'),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: ConstColor.titleColor.withAlpha(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: 'KEY SET #1',
                    textSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.bodyColor,
                    letterSpacing: 0.4,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    fromTitle: 'Key Type',
                    textController: controller.keyTypeController,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          fromTitle: 'Quantity',
                          textController: controller.keyQuantityController,
                          keyboardType: TextInputType.number,
                          numeric: true,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomTextFormField(
                          fromTitle: 'Location / Tag',
                          textController: controller.keyLocationController,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    fromTitle: 'Held By',
                    textController: controller.keyHeldByController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.saveKeySet,
              child: CustomText(
                title: isEdit ? 'Save Changes' : 'Save Key Register',
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
