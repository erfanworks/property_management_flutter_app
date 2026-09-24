// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/tenant_documents_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../controller/property_detail_controller.dart';
import '../model/property_detail_model.dart';

class TenantDocumentsScreen extends GetView<PropertyDetailController> {
  const TenantDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.documents,
        actions: [
          Center(
            child: GestureDetector(
              onTap: controller.showUploadDocumentPicker,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ConstColor.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded, size: 16.sp, color: Colors.white),
                    SizedBox(width: 4.w),
                    CustomText(
                      title: ConstString.addDoc,
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
      body: Obx(
        () => GridView.builder(
          padding: EdgeInsets.all(16.r),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 14.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 0.70,
          ),
          itemCount: controller.tenantDocumentsRx.length,
          itemBuilder: (context, index) =>
              _DocCard(data: controller.tenantDocumentsRx[index]),
        ),
      ),
    );
  }
}

class _DocCard extends StatelessWidget {
  const _DocCard({required this.data});

  final TenantDocumentModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: data.bgColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              data.iconData,
              color: data.iconColor,
              size: 26.sp,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        CustomText(
          title: data.fileName,
          textSize: 11.sp,
          fontWeight: FontWeight.w600,
          textColor: ConstColor.titleColor,
          maxLine: 1,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        CustomText(
          title: data.dateLabel,
          textSize: 10.sp,
          textColor: ConstColor.bodyColor.withAlpha(180),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

extension _TenantDocCardStyle on TenantDocumentModel {
  Color get bgColor {
    final cat = categoryLabel.toLowerCase();
    final name = fileName.toLowerCase();
    if (cat.contains('gas') || name.contains('gas')) return const Color(0xFFFDE8E8);
    if (cat.contains('electrical') || name.contains('eicr')) return const Color(0xFFFEF3E8);
    if (cat.contains('deposit') || name.contains('deposit')) return const Color(0xFFE6F4EA);
    return const Color(0xFFE8F0FE);
  }

  Color get iconColor {
    final cat = categoryLabel.toLowerCase();
    final name = fileName.toLowerCase();
    if (cat.contains('gas') || name.contains('gas')) return const Color(0xFFD93025);
    if (cat.contains('electrical') || name.contains('eicr')) return const Color(0xFFE65100);
    if (cat.contains('deposit') || name.contains('deposit')) return const Color(0xFF1E8E3E);
    return const Color(0xFF1A73E8);
  }

  IconData get iconData {
    final name = fileName.toLowerCase();
    if (name.contains('nid') || name.contains('.jpg') || name.contains('.png') || name.contains('proof')) {
      return Icons.image_outlined;
    }
    return Icons.description_outlined;
  }
}
