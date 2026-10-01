// lib/screens/UserScreen/LandlordAllScreen/Contractors/contractor_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/contractors_controller.dart';

class ContractorDetailScreen extends GetView<ContractorsController> {
  const ContractorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final c = controller.selectedContractor.value;
      if (c == null) return const Scaffold(body: SizedBox.shrink());
      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.contractors),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(32.r), child: AppImage(url: c.avatarUrl, width: 64.r, height: 64.r, fit: BoxFit.cover)),
                  SizedBox(height: 10.h),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomText(title: c.name, textSize: 16.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                    if (c.isVerified) ...[SizedBox(width: 4.w), Icon(Icons.verified_rounded, size: 16.sp, color: ConstColor.primaryColor)],
                  ]),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h), decoration: BoxDecoration(color: c.roleColor.withAlpha(30), borderRadius: BorderRadius.circular(20.r)), child: CustomText(title: c.roleLabel, textSize: 11.sp, fontWeight: FontWeight.w600, textColor: c.roleColor)),
                      SizedBox(width: 8.w),
                      if (c.rating != null)
                        GestureDetector(
                          onTap: controller.openReviews,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(color: ConstColor.contractorIconBg, borderRadius: BorderRadius.circular(20.r)),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.star_rounded, size: 14.sp, color: Colors.amber), CustomText(title: '${c.rating}', textSize: 12.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor)]),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {}, // TODO: wire native call intent
                          icon: Icon(Icons.call_outlined, size: 16.sp, color: ConstColor.titleColor),
                          label: CustomText(title: ConstString.call, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: ConstColor.dividerColor), padding: EdgeInsets.symmetric(vertical: 12.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {}, // TODO: wire chat/message
                          icon: Icon(Icons.chat_bubble_outline_rounded, size: 16.sp, color: Colors.white),
                          label: CustomText(title: ConstString.message, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: Colors.white),
                          style: ElevatedButton.styleFrom(backgroundColor: ConstColor.primaryColor, padding: EdgeInsets.symmetric(vertical: 12.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: ConstString.contactDetails, textSize: 10.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.4),
                  SizedBox(height: 10.h),
                  Row(children: [Icon(Icons.phone_outlined, size: 14.sp, color: ConstColor.bodyColor), SizedBox(width: 8.w), Expanded(child: CustomText(title: 'Phone', textSize: 12.sp, textColor: ConstColor.bodyColor)), CustomText(title: c.phone ?? '-', textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor)]),
                  SizedBox(height: 10.h),
                  Row(children: [Icon(Icons.email_outlined, size: 14.sp, color: ConstColor.bodyColor), SizedBox(width: 8.w), Expanded(child: CustomText(title: 'Email', textSize: 12.sp, textColor: ConstColor.bodyColor)), Flexible(child: CustomText(title: c.email ?? '-', textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor, textAlign: TextAlign.right))]),
                  SizedBox(height: 10.h),
                  CustomText(title: ConstString.tapToCopyDetails, textSize: 11.sp, textColor: ConstColor.bodyColor),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}