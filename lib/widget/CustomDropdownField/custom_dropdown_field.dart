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
              children: [
                if (labelIcon != null) ...[
                  Icon(labelIcon, size: 15.sp, color: ConstColor.titleColor),
                  SizedBox(width: 6.w),
                ],
                Expanded(
                  child: CustomText(
                    title: label!,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            border: Border.all(color: ConstColor.dividerColor),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              borderRadius: BorderRadius.all(Radius.circular(12)),
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