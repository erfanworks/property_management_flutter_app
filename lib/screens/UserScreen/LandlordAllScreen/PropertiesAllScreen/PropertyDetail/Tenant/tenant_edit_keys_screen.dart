// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/tenant_edit_keys_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../controller/property_detail_controller.dart';

class TenantEditKeysScreen extends GetView<PropertyDetailController> {
  const TenantEditKeysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.editKeys),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            ...controller.editingKeySets.map((k) {
              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: ConstColor.titleColor.withAlpha(30))
                ),
                child: Column(
                  children: [
                    CustomTextFormField(
                      fromTitle: ConstString.keyType,
                      textController: TextEditingController(text: k.keyType)
                        ..selection = TextSelection.collapsed(
                          offset: k.keyType.length,
                        ),
                      onChanged: (v) =>
                          controller.updateEditingKeyField(k.id, keyType: v),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            fromTitle: ConstString.quantity,
                            textController: TextEditingController(
                              text: '${k.quantity}',
                            ),
                            keyboardType: TextInputType.number,
                            numeric: true,
                            onChanged: (v) => controller.updateEditingKeyField(
                              k.id,
                              quantity: int.tryParse(v) ?? k.quantity,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomTextFormField(
                            fromTitle: ConstString.location,
                            textController:
                                TextEditingController(text: k.location)
                                  ..selection = TextSelection.collapsed(
                                    offset: k.location.length,
                                  ),
                            onChanged: (v) => controller.updateEditingKeyField(
                              k.id,
                              location: v,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      fromTitle: ConstString.heldBy,
                      textController: TextEditingController(text: k.heldBy)
                        ..selection = TextSelection.collapsed(
                          offset: k.heldBy.length,
                        ),
                      onChanged: (v) =>
                          controller.updateEditingKeyField(k.id, heldBy: v),
                    ),
                    SizedBox(height: 6.h),
                    CustomElevatedButton(
                      onPressed: () => controller.removeEditingKeySet(k.id),
                      isOutLined: true,
                      elevation: 0,
                      outLineColour: ConstColor.errorColor,
                      height: 40,
                      child: CustomText(
                        title: ConstString.removeKeySet,
                        textColor: ConstColor.errorColor,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }),
            CustomElevatedButton(
              onPressed: controller.addEditingKeySet,
              isOutLined: true,
              outLineColour: ConstColor.dividerColor,
              elevation: 0,
              icon: Icon(
                Icons.add_rounded,
                color: ConstColor.titleColor,
                size: 18.sp,
              ),
              child: CustomText(
                title: ConstString.addKeySet,
                textColor: ConstColor.titleColor,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: controller.saveKeys,
              child: CustomText(
                title: ConstString.saveKeys,
                textColor: Colors.white,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
