// lib/common_widget/section_header/custom_section_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/const_color.dart';
import '../text/custom_text.dart';

class CustomSectionHeader extends StatelessWidget {
  const CustomSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title: title,
          textSize: 16.sp,
          fontWeight: FontWeight.w700,
          textColor: ConstColor.titleColor,
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onActionTap,
            child: CustomText(
              title: actionLabel!,
              textSize: 13.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.primaryColor,
            ),
          ),
      ],
    );
  }
}