// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/tenant_keys_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../../../HomeTabAllScreen/Finance/payment_record_detail_screen.dart';
import '../controller/property_detail_controller.dart';

class TenantKeysScreen extends GetView<PropertyDetailController> {
  const TenantKeysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tenant = controller.selectedTenant.value;
      if (tenant == null) return const Scaffold(body: SizedBox.shrink());

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(
          title: ConstString.keys,
          actions: [
            AppBarTextAction(
              label: ConstString.edit,
              onTap: controller.openEditKeys,
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: tenant.keySets.map((k) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: ConstColor.titleColor.withAlpha(30))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              title: k.keyType,
                              textSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              textColor: ConstColor.titleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DetailRow(
                      label: ConstString.quantity,
                      value: 'x${k.quantity}',
                    ),
                    DetailRow(label: ConstString.location, value: k.location),
                    DetailRow(
                      label: ConstString.heldBy,
                      value: k.heldBy,
                      isLast: true,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
