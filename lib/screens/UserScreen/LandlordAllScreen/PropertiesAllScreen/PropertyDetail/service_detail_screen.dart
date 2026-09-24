// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/service_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../HomeTabAllScreen/Finance/payment_record_detail_screen.dart';
import 'controller/property_detail_controller.dart';
import 'model/service_model.dart';

class ServiceDetailScreen extends GetView<PropertyDetailController> {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.selectedService.value;
      if (data == null) return const Scaffold(body: SizedBox.shrink());

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(
          title: data.type.label,
          actions: [AppBarTextAction(label: ConstString.edit, icon: Icons.edit_outlined, onTap: controller.openServiceEdit)],
        ),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            if (data.photoPath != null) ...[
              ClipRRect(borderRadius: BorderRadius.circular(16.r), child: AppImage(path: data.photoPath, width: double.infinity, height: 150.h, fit: BoxFit.cover)),
              SizedBox(height: 14.h),
            ],
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                children: data.fields.asMap().entries.map((e) {
                  return DetailRow(label: e.value.label, value: e.value.value.isEmpty ? '-' : e.value.value, isLast: e.key == data.fields.length - 1);
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}