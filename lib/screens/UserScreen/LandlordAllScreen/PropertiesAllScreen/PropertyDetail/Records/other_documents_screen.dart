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
          GestureDetector(
            onTap: () => controller.pickAndUploadOtherDocument(
              categoryLabel: 'Custom Document',
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ConstColor.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ConstColor.titleColor.withAlpha(20)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: ConstColor.primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description_outlined,
              color: ConstColor.primaryColor,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: data.fileName,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.titleColor,
                  maxLine: 1,
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Flexible(
                      child: CustomText(
                        title: '${data.dateLabel}  •  ${data.categoryLabel}',
                        textSize: 11.sp,
                        textColor: ConstColor.bodyColor,
                        maxLine: 2,
                      ),
                    ),
                    if (data.isShared) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: ConstColor.primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: CustomText(
                          title: ConstString.shared,
                          textSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          textColor: ConstColor.primaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => controller.shareDocument(data.fileName),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: Icon(
                Icons.share_outlined,
                size: 18.sp,
                color: ConstColor.bodyColor,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: () => controller.deleteOtherDocument(data.id),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: Icon(
                Icons.delete_outline_rounded,
                size: 18.sp,
                color: ConstColor.bodyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
