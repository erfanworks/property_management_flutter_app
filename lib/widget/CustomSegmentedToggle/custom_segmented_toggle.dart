// lib/common_widget/toggle/custom_segmented_toggle.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/const_color.dart';
import '../text/custom_text.dart';

class SegmentedOption {
  final String label;
  final Color? dotColor;
  const SegmentedOption({required this.label, this.dotColor});
}

class CustomSegmentedToggle extends StatelessWidget {
  const CustomSegmentedToggle({super.key, required this.options, required this.selectedIndex, required this.onChanged});

  final List<SegmentedOption> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(options.length, (index) {
        final isSelected = index == selectedIndex;
        final option = options[index];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == options.length - 1 ? 0 : 8.w),
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? ConstColor.primaryColor : Colors.white,
                  border: Border.all(color: isSelected ? ConstColor.primaryColor : ConstColor.dividerColor),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (option.dotColor != null) ...[
                      Container(width: 6.r, height: 6.r, decoration: BoxDecoration(color: option.dotColor, shape: BoxShape.circle)),
                      SizedBox(width: 6.w),
                    ],
                    CustomText(title: option.label, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: isSelected ? Colors.white : ConstColor.titleColor),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}