// lib/screens/UserScreen/LandlordAllScreen/Contractors/contractor_reviews_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/contractors_controller.dart';

class ContractorReviewsScreen extends GetView<ContractorsController> {
  const ContractorReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final c = controller.selectedContractor.value;
      if (c == null) return const Scaffold(body: SizedBox.shrink());
      final avg = c.reviews.isEmpty ? 0 : c.reviews.fold<double>(0, (s, r) => s + r.rating) / c.reviews.length;

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.reviewsLabel),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: '${ConstString.verifiedReviews} (${c.reviews.length})', textSize: 12.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.4),
                Row(children: [Icon(Icons.star_rounded, size: 14.sp, color: Colors.amber), CustomText(title: '${avg.toStringAsFixed(1)} ${ConstString.averageLabel}', textSize: 12.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor)]),
              ],
            ),
            SizedBox(height: 10.h),
            ...c.reviews.map((r) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(title: r.reviewerName, textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                        Row(children: List.generate(5, (i) => Icon(i < r.rating ? Icons.star_rounded : Icons.star_border_rounded, size: 14.sp, color: Colors.amber))),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomText(title: r.comment, textSize: 12.sp, textColor: ConstColor.titleColor, maxLine: 3),
                    SizedBox(height: 6.h),
                    CustomText(title: 'Job: ${r.jobLabel}', textSize: 11.sp, textColor: ConstColor.bodyColor),
                    CustomText(title: r.dateLabel, textSize: 10.sp, textColor: ConstColor.bodyColor),
                  ],
                ),
              ),
            )),
          ],
        ),
      );
    });
  }
}