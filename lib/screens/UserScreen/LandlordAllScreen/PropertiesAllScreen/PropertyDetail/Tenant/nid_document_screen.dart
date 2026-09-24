// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/nid_document_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../controller/property_detail_controller.dart';

class NidDocumentScreen extends GetView<PropertyDetailController> {
  const NidDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tenant = controller.selectedTenant.value;
      if (tenant == null) return const Scaffold(body: SizedBox.shrink());

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.nidTitle),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: ConstColor.titleColor.withAlpha(30))
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: AppImage(
                      url: tenant.avatarUrl,
                      width: 72.r,
                      height: 88.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: 'UNITED KINGDOM · ${ConstString.photoId}',
                          textSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          textColor: ConstColor.primaryColor,
                          letterSpacing: 0.4,
                        ),
                        CustomText(
                          title: tenant.fullName,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.titleColor,
                        ),
                        CustomText(
                          title: '${ConstString.documentNo} ${tenant.nid}',
                          textSize: 12.sp,
                          textColor: ConstColor.bodyColor,
                        ),
                        CustomText(
                          title:
                              '${tenant.nidProofFileName} · ${ConstString.onFile}',
                          textSize: 12.sp,
                          textColor: ConstColor.bodyColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            CustomElevatedButton(
              onPressed: () {},
              // TODO: Wire real download once backend serves file URLs.
              icon: Icon(
                Icons.download_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
              child: CustomText(
                title: 'Download',
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
