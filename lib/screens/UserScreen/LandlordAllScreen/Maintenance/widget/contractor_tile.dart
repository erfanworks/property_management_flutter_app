// lib/screens/UserScreen/LandlordAllScreen/Maintenance/widget/contractor_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/text/custom_text.dart';
import '../model/contractor_model.dart';
import '../../../../../widget/CustomStatusChip/custom_status_chip.dart';

class ContractorTile extends StatelessWidget {
  const ContractorTile({super.key, required this.data, this.trailing, this.subtitle});

  final ContractorModel data;
  final Widget? trailing;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: AppImage(url: data.avatarUrl, width: 40.r, height: 40.r, fit: BoxFit.cover),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(title: data.name, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                    if (data.isSuggested) ...[
                      SizedBox(width: 6.w),
                      CustomStatusChip(label: ConstString.suggested, color: ConstColor.primaryColor, backgroundColor: ConstColor.infoBg),
                    ],
                  ],
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Container(width: 6.r, height: 6.r, decoration: BoxDecoration(color: data.roleColor, shape: BoxShape.circle)),
                    SizedBox(width: 5.w),
                    CustomText(title: data.roleLabel, textSize: 11.sp, textColor: ConstColor.bodyColor),
                  ],
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 3.h),
                  CustomText(title: subtitle!, textSize: 11.sp, textColor: ConstColor.bodyColor),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
