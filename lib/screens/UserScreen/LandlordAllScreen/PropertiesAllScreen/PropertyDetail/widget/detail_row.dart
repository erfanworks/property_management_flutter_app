// lib/common_widget/detail_row/detail_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/text/custom_text.dart';

class DetailRow extends StatelessWidget {
  const DetailRow({super.key, required this.label, required this.value, this.isLast = false, this.icon});
  final String label;
  final String value;
  final bool isLast;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(border: isLast ? null : Border(bottom: BorderSide(color: ConstColor.dividerColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[Icon(icon, size: 14.sp, color: ConstColor.bodyColor), SizedBox(width: 6.w)],
              CustomText(title: label, textSize: 13.sp, textColor: ConstColor.bodyColor),
            ],
          ),
          Flexible(child: CustomText(title: value, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor, textAlign: TextAlign.right, maxLine: 2)),
        ],
      ),
    );
  }
}