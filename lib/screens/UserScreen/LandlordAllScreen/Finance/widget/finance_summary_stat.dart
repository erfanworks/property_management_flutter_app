// lib/screens/UserScreen/LandlordAllScreen/Finance/widget/finance_summary_stat.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../widget/text/custom_text.dart';

class FinanceSummaryStat extends StatelessWidget {
  const FinanceSummaryStat({super.key, required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(title: label.toUpperCase(), textSize: 10.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.4),
        SizedBox(height: 3.h),
        CustomText(title: value, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: color),
      ],
    );
  }
}