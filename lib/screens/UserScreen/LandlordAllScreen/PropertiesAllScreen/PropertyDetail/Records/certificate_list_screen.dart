// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/certificate_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/records_controller.dart';
import 'model/records_model.dart';

class CertificateListScreen extends StatelessWidget {
  const CertificateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecordsController>(tag: 'records');
    return Obx(() {
      final type = controller.selectedComplianceType.value;
      if (type == null) return const Scaffold(body: SizedBox.shrink());
      final current = controller.currentCertFor(type);
      final history = controller.historyFor(type);

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: type.screenTitle),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            if (current == null) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 32.h),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
                child: Column(
                  children: [
                    Icon(Icons.description_outlined, size: 36.sp, color: ConstColor.bodyColor),
                    SizedBox(height: 10.h),
                    CustomText(title: ConstString.noFilesUploaded, textSize: 14.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                    SizedBox(height: 4.h),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 24.w), child: CustomText(title: ConstString.uploadGasCertHint, textSize: 12.sp, textColor: ConstColor.bodyColor, textAlign: TextAlign.center, maxLine: 2)),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                onPressed: () => controller.pickAndUploadCertificate(type),
                icon: Icon(Icons.upload_rounded, color: Colors.white, size: 18.sp),
                child: CustomText(title: ConstString.uploadCertificate, textColor: Colors.white, textSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ] else ...[
              CustomText(title: ConstString.currentCertificate, textSize: 11.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.5),
              SizedBox(height: 8.h),
              _CertTile(cert: current, type: type, onTap: () => type == ComplianceType.gasSafety ? controller.openCertificateDetail(current) : controller.downloadDocument(current.fileName)),
              if (history.isNotEmpty) ...[
                SizedBox(height: 16.h),
                CustomText(title: '${ConstString.historyLabel} (${history.length})', textSize: 11.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.5),
                SizedBox(height: 8.h),
                ...history.map((c) => Padding(padding: EdgeInsets.only(bottom: 8.h), child: _CertTile(cert: c, type: type, onTap: () => type == ComplianceType.gasSafety ? controller.openCertificateDetail(c) : controller.downloadDocument(c.fileName)))),
              ],
            ],
          ],
        ),
      );
    });
  }
}

class _CertTile extends StatelessWidget {
  const _CertTile({required this.cert, required this.type, required this.onTap});
  final CertificateFileModel cert;
  final ComplianceType type;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          children: [
            CustomIconBadge(icon: type.icon, iconColor: type.iconColor, backgroundColor: type.iconColor.withAlpha(30), size: 38, isCircle: false, borderRadius: 10),
            SizedBox(width: 12.w),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: cert.fileName, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor, maxLine: 1),
                        CustomText(title: '${cert.sizeLabel} · ${cert.dateLabel}', textSize: 11.sp, textColor: ConstColor.bodyColor),
                      ],
                    ),
                  ),
                  if (cert.isCurrent)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(color: ConstColor.infoBg, borderRadius: BorderRadius.circular(20.r)),
                      child: CustomText(title: ConstString.current, textSize: 10.sp, fontWeight: FontWeight.w600, textColor: ConstColor.primaryColor),
                    ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 18.sp, color: ConstColor.bodyColor),
          ],
        ),
      ),
    );
  }
}