// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/house_rules_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/house_rules_controller.dart';

class HouseRulesScreen extends StatelessWidget {
  const HouseRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HouseRulesController());
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: 'House Rules & Policies',
        actions: [
          GestureDetector(
            onTap: controller.openEdit,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ConstColor.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: 'Edit',
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ConstColor.titleColor.withAlpha(30))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(controller.rules.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: '${index + 1}.',
                          textSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.titleColor,
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: CustomText(
                            title: controller.rules[index],
                            textSize: 13.sp,
                            textColor: ConstColor.titleColor,
                            maxLine: 4,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
