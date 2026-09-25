// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/gas_certificate_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../../../HomeTabAllScreen/Finance/payment_record_detail_screen.dart';
import 'controller/records_controller.dart';
import 'model/records_model.dart';

class GasCertificateDetailScreen extends StatelessWidget {
  const GasCertificateDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecordsController>(tag: 'records');
    return Obx(() {
      final cert = controller.selectedCertificate.value;
      if (cert == null) return const Scaffold(body: SizedBox.shrink());

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.gasCertificates),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ConstColor.titleColor.withAlpha(30))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomText(
                          title: ConstString.landlordGasSafetyRecord,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.titleColor,
                          maxLine: 2,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            title: ConstString.refCertNo,
                            textSize: 9.sp,
                            textColor: ConstColor.bodyColor,
                          ),
                          CustomText(
                            title: cert.refCertNo ?? '-',
                            textSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            textColor: ConstColor.titleColor,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  DetailRow(
                    label: ConstString.propertyAddress,
                    value: cert.propertyAddress ?? '-',
                  ),
                  DetailRow(
                    label: ConstString.landlordOwner,
                    value: cert.landlordOwner ?? '-',
                  ),
                  DetailRow(
                    label: ConstString.inspectionDate,
                    value: cert.inspectionDate ?? '-',
                  ),
                  DetailRow(
                    label: ConstString.nextDueExpiry,
                    value: cert.nextDueDate ?? '-',
                  ),
                  DetailRow(
                    label: ConstString.registeredEngineer,
                    value: cert.engineerName ?? '-',
                  ),
                  DetailRow(
                    label: ConstString.engineerNotes,
                    value: cert.engineerNotes ?? '-',
                    isLast: true,
                  ),
                  SizedBox(height: 14.h),
                  CustomText(
                    title: ConstString.applianceChecks,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.bodyColor,
                    letterSpacing: 0.5,
                  ),
                  SizedBox(height: 8.h),
                  ...?cert.applianceChecks?.map(
                    (a) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: a.name,
                                  textSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: ConstColor.titleColor,
                                ),
                                CustomText(
                                  title: a.detail,
                                  textSize: 11.sp,
                                  textColor: ConstColor.bodyColor,
                                  maxLine: 2,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            title: a.passed ? ConstString.pass : 'FAIL',
                            textSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            textColor: a.passed
                                ? ConstColor.tenantIconColor
                                : ConstColor.errorColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: ConstColor.dividerColor),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: ConstString.overallOutcome,
                              textSize: 11.sp,
                              textColor: ConstColor.bodyColor,
                            ),
                            CustomText(
                              title: cert.overallOutcome ?? '-',
                              textSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              textColor: ConstColor.tenantIconColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: CustomText(
                          title: ConstString.digitalRecordOnFile,
                          textSize: 11.sp,
                          textColor: ConstColor.bodyColor,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              onPressed: () => controller.downloadDocument(cert.fileName),
              child: CustomText(
                title: ConstString.downloadDocumentPdf,
                textColor: Colors.white,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            CustomElevatedButton(
              onPressed: () => controller.deleteCertificate(
                ComplianceType.gasSafety,
                cert.id,
              ),
              isOutLined: true,
              elevation: 0,
              outLineColour: ConstColor.errorColor,
              child: CustomText(
                title: ConstString.deleteDocument,
                textColor: ConstColor.errorColor,
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
