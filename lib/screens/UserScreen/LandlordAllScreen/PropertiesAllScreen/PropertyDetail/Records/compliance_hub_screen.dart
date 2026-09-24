// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/compliance_hub_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
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
        title: ConstString.certificatesAndCompliance,
        actions: [AppBarTextAction(label: ConstString.upload, icon: Icons.upload_rounded, onTap: () => _showUploadPicker(controller))],
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
          .map((type) => ActionSheetItem(label: type.label, icon: type.icon, onTap: () => controller.pickAndUploadCertificate(type)))
          .toList(),
    );
  }
}