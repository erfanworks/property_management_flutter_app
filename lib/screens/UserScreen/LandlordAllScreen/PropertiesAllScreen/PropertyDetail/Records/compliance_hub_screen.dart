import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../widget/action_sheet.dart';
import '../widget/nav_list_tile.dart';
import 'controller/records_controller.dart';
import 'model/records_model.dart';

class ComplianceHubScreen extends StatelessWidget {
  const ComplianceHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecordsController>(tag: 'records');
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.compliance,
        actions: [
          GestureDetector(
            onTap: () => _showUploadPicker(controller),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ConstColor.primaryColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.upload_rounded,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: ConstString.upload,
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
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: ComplianceType.values.map((type) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: NavListTile(icon: type.icon, iconColor: type.iconColor, iconBg: type.iconColor.withAlpha(30), title: type.label, onTap: () => controller.openCertificateList(type)),
          );
        }).toList(),
      ),
    );
  }

  void _showUploadPicker(RecordsController controller) {
    CustomActionSheet.show(
      ComplianceType.values
          .map((type) => ActionSheetItem(
                label: type.label,
                icon: type.icon,
                color: type.iconColor,
                iconBg: type.iconColor.withAlpha(25),
                onTap: () => controller.pickAndUploadCertificate(type),
              ))
          .toList(),
      title: ConstString.uploadDocumentTitle,
    );
  }
}