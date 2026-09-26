// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/property_photos_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:imusa04_landlord_app/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/widget/action_sheet.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../controller/property_detail_controller.dart';

class PropertyPhotosScreen extends GetView<PropertyDetailController> {
  const PropertyPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.propertyPhotos,
        actions: [
          Center(
            child: GestureDetector(
              onTap: controller.addPropertyPhoto,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ConstColor.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.white.withAlpha(80)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded, size: 16.sp, color: Colors.white),
                    SizedBox(width: 4.w),
                    CustomText(
                      title: ConstString.addPhoto,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final photos = controller.property.value?.photoUrls ?? [];
        return GridView.builder(
          padding: EdgeInsets.all(16.r),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.2,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppImage(filePath: photos[index], fit: BoxFit.cover),
                Positioned(
                  top: 6.h,
                  right: 6.w,
                  child: GestureDetector(
                    onTap: () => CustomActionSheet.show([
                      ActionSheetItem(
                        label: ConstString.setAsCover,
                        icon: Icons.star_outline_rounded,
                        onTap: () => controller.setPhotoAsCover(index),
                      ),
                      ActionSheetItem(
                        label: ConstString.removePhoto,
                        icon: Icons.delete_outline_rounded,
                        color: ConstColor.errorColor,
                        onTap: () => controller.removePropertyPhoto(index),
                      ),
                    ]),
                    child: CircleAvatar(
                      radius: 14.r,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.more_horiz_rounded,
                        size: 16.sp,
                        color: ConstColor.titleColor,
                      ),
                    ),
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
