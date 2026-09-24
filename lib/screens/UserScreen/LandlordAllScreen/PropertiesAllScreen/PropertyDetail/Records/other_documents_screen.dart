// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/other_documents_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/records_controller.dart';
import 'model/records_model.dart';

class OtherDocumentsScreen extends StatelessWidget {
  const OtherDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecordsController>(tag: 'records');
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.otherDocuments,
        actions: [
          AppBarTextAction(
            label: ConstString.upload,
            icon: Icons.upload_rounded,
            onTap: () => controller.pickAndUploadOtherDocument(
              categoryLabel: 'Custom Document',
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(16.r),
          itemCount: controller.otherDocuments.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) => _OtherDocTile(
            data: controller.otherDocuments[index],
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class _OtherDocTile extends StatelessWidget {
  const _OtherDocTile({required this.data, required this.controller});

  final OtherDocumentModel data;
  final RecordsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.description_outlined,
            color: ConstColor.primaryColor,
            size: 22.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: data.fileName,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.titleColor,
                  maxLine: 1,
                ),
                Row(
                  children: [
                    CustomText(
                      title: '${data.dateLabel} · ${data.categoryLabel}',
                      textSize: 11.sp,
                      textColor: ConstColor.bodyColor,
                      maxLine: 1,
                    ),
                    if (data.isShared) ...[
                      SizedBox(width: 6.w),
                      CustomText(
                        title: ConstString.shared,
                        textSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        textColor: ConstColor.primaryColor,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.shareDocument(data.fileName),
            icon: Icon(
              Icons.ios_share_rounded,
              size: 18.sp,
              color: ConstColor.bodyColor,
            ),
          ),
          IconButton(
            onPressed: () => controller.deleteOtherDocument(data.id),
            icon: Icon(
              Icons.delete_outline_rounded,
              size: 18.sp,
              color: ConstColor.errorColor,
            ),
          ),
        ],
      ),
    );
  }
}
