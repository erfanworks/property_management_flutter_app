// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/lease_agreement_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../../../HomeTabAllScreen/Finance/payment_record_detail_screen.dart';
import '../controller/property_detail_controller.dart';

class LeaseAgreementScreen extends GetView<PropertyDetailController> {
  const LeaseAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tenant = controller.selectedTenant.value;
      if (tenant == null) return const Scaffold(body: SizedBox.shrink());
      final lease = tenant.leaseAgreement;

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.leaseAgreement),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: ConstColor.titleColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: lease.documentName,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.titleColor,
                  ),
                  SizedBox(height: 10.h),
                  DetailRow(
                    label: ConstString.document,
                    value: lease.documentName,
                  ),
                  DetailRow(label: ConstString.issued, value: lease.issuedDate),
                  DetailRow(
                    label: ConstString.landlord,
                    value: lease.landlordName,
                  ),
                  DetailRow(label: ConstString.tenant, value: tenant.fullName),
                  DetailRow(
                    label: ConstString.property,
                    value: tenant.propertyName,
                  ),
                  DetailRow(label: ConstString.unit, value: tenant.unitLabel),
                  DetailRow(
                    label: ConstString.address,
                    value: tenant.address,
                    isLast: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
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
            SizedBox(height: 10.h),
            CustomElevatedButton(
              onPressed: () {},
              // TODO: wire delete once backend endpoint is ready
              isOutLined: true,
              elevation: 0,
              outLineColour: ConstColor.errorColor,
              icon: Icon(
                Icons.delete_outline,
                color: ConstColor.errorColor,
                size: 18.sp,
              ),
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
