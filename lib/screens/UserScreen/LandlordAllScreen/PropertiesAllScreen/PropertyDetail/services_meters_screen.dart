// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/services_meters_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/property_detail_controller.dart';
import 'model/service_model.dart';

class ServicesMetersScreen extends GetView<PropertyDetailController> {
  const ServicesMetersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.servicesAndMeters),
      body: Obx(
            () => GridView.builder(
          padding: EdgeInsets.all(16.r),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12.h, crossAxisSpacing: 12.w, childAspectRatio: 0.85),
          itemCount: controller.services.length,
          itemBuilder: (context, index) => _ServiceCard(data: controller.services[index], onTap: () => controller.openServiceDetail(controller.services[index])),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.data, required this.onTap});
  final ServiceModel data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            data.photoPath != null ? AppImage(path: data.photoPath, fit: BoxFit.cover) : Container(color: ConstColor.dividerColor),
            DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withAlpha(160)]))),
            Positioned(
              left: 10.w,
              right: 10.w,
              bottom: 10.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Icon(data.type.icon, size: 14.sp, color: Colors.white), SizedBox(width: 4.w), CustomText(title: data.type.label, textSize: 13.sp, fontWeight: FontWeight.w700, textColor: Colors.white)]),
                  CustomText(title: data.summaryLine, textSize: 10.sp, textColor: Colors.white.withAlpha(220), maxLine: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}