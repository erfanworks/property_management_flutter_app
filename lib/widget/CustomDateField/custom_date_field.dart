// lib/common_widget/datefield/custom_date_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/const_color.dart';
import '../text/custom_text.dart';

class CustomDateField extends StatelessWidget {
  const CustomDateField({super.key, this.label, required this.date, required this.onTap, this.hintText = 'mm/dd/yyyy', this.backgroundColor});

  final String? label;
  final DateTime? date;
  final VoidCallback onTap;
  final String hintText;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(padding: EdgeInsets.only(bottom: 6.h), child: CustomText(title: label!, textSize: 14.sp, fontWeight: FontWeight.w600)),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              border: Border.all(color: ConstColor.dividerColor),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: date != null ? _format(date!) : hintText, textSize: 14.sp, textColor: date != null ? ConstColor.titleColor : ConstColor.bodyColor),
                Icon(Icons.calendar_today_outlined, size: 16.sp, color: ConstColor.bodyColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _format(DateTime d) => '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';
}