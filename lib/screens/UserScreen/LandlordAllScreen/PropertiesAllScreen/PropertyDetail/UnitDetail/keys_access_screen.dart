// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/keys_access_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/unit_detail_controller.dart';
import 'dialog/key_set_dialogs.dart';

class KeysAccessScreen extends GetView<UnitDetailController> {
  const KeysAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: 'Keys & Access',
        actions: [
          GestureDetector(
            onTap: controller.startAddKeySet,
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
                    Icons.add_rounded,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: 'Add Key Set',
                    textSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.keySetsRx.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              children: [
                SizedBox(height: 60.h),
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: ConstColor.dividerColor,
                  child: Icon(
                    Icons.vpn_key_outlined,
                    color: ConstColor.bodyColor,
                  ),
                ),
                SizedBox(height: 12.h),
                CustomText(
                  title: 'No key sets for this filter',
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.titleColor,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title:
                      'Add front door, postbox, or fob records for this unit.',
                  textSize: 12.sp,
                  textColor: ConstColor.bodyColor,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                ),
              ],
            ),
          );
        }
        return ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Row(
              children: [
                Expanded(
                  child: _StatBox(
                    label: 'TOTAL',
                    value: '${controller.totalKeySets}',
                    sub: '${controller.totalKeyQuantity} sets',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _StatBox(
                    label: 'TENANT',
                    value: '${controller.issuedQuantity}',
                    sub: 'Issued',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _StatBox(
                    label: 'IN SAFE',
                    value: '${controller.inSafeQuantity}',
                    sub: 'Office',
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            ...controller.keySetsRx.map(
              (k) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: GestureDetector(
                  onTap: () => KeySetDialogs.showDetail(k, controller),
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.vpn_key_outlined,
                          size: 18.sp,
                          color: ConstColor.primaryColor,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomText(
                            title: k.keyType,
                            textSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            textColor: ConstColor.titleColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 18.sp,
                          color: ConstColor.bodyColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.label, required this.value, required this.sub});

  final String label;
  final String value;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: ConstColor.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.vpn_key_outlined, size: 12.sp, color: Colors.white70),
              SizedBox(width: 4.w),
              CustomText(
                title: label,
                textSize: 9.sp,
                fontWeight: FontWeight.w600,
                textColor: Colors.white70,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          CustomText(
            title: value,
            textSize: 18.sp,
            fontWeight: FontWeight.w800,
            textColor: Colors.white,
          ),
          CustomText(title: sub, textSize: 10.sp, textColor: Colors.white70),
        ],
      ),
    );
  }
}
