// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/floor_plans_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:imusa04_landlord_app/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/widget/action_sheet.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'controller/property_detail_controller.dart';

class FloorPlansScreen extends GetView<PropertyDetailController> {
  const FloorPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.floorPlans,
        actions: [AppBarTextAction(label: ConstString.addFloorPlan, icon: Icons.add_rounded, onTap: controller.addFloorPlan)],
      ),
      body: Obx(() {
        final plans = controller.property.value?.floorPlanUrls ?? [];
        return GridView.builder(
          padding: EdgeInsets.all(16.r),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12.h, crossAxisSpacing: 12.w, childAspectRatio: 0.85),
          itemCount: plans.length,
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppImage(path: plans[index], fit: BoxFit.cover),
                Positioned(
                  top: 6.h,
                  right: 6.w,
                  child: GestureDetector(
                    onTap: () => CustomActionSheet.show([
                      ActionSheetItem(label: ConstString.removeFloorPlan, icon: Icons.delete_outline_rounded, color: ConstColor.errorColor, onTap: () => controller.removeFloorPlan(index)),
                    ]),
                    child: CircleAvatar(radius: 14.r, backgroundColor: Colors.white, child: Icon(Icons.more_horiz_rounded, size: 16.sp, color: ConstColor.titleColor)),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}