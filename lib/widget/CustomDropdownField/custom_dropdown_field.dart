// lib/common_widget/dropdown/custom_dropdown_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/const_color.dart';
import '../text/custom_text.dart';

class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    this.label,
    this.labelIcon,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = 'Select',
    this.backgroundColor,
  });

  final String? label;
  final IconData? labelIcon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (labelIcon != null) ...[
                  Icon(labelIcon, size: 15.sp, color: ConstColor.titleColor),
                  SizedBox(width: 6.w),
                ],
                CustomText(title: label!, textSize: 14.sp, fontWeight: FontWeight.w600),
              ],
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: ConstColor.bodyColor),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              dropdownColor: Colors.white,
              hint: CustomText(title: hintText, textSize: 14.sp, textColor: ConstColor.bodyColor),
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: ConstColor.bodyColor),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}