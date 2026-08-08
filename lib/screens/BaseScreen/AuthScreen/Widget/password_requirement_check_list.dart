import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/text/custom_text.dart';

/// Reused across Create New Password / Sign Up screens.
class PasswordRequirementChecklist extends StatelessWidget {
  final bool hasMinLength;
  final bool hasNumber;
  final bool hasUppercase;

  const PasswordRequirementChecklist({
    super.key,
    required this.hasMinLength,
    required this.hasNumber,
    required this.hasUppercase,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: ConstString.passwordMustInclude,
            textSize: 13.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.titleColor,
          ),
          SizedBox(height: 8.h),
          _RequirementRow(label: ConstString.reqMinChars, isMet: hasMinLength),
          _RequirementRow(label: ConstString.reqOneNumber, isMet: hasNumber),
          _RequirementRow(label: ConstString.reqOneUppercase, isMet: hasUppercase),
        ],
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final String label;
  final bool isMet;

  const _RequirementRow({required this.label, required this.isMet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 16.sp,
            color: isMet ? const Color(0xFF16A34A) : ConstColor.bodyColor,
          ),
          SizedBox(width: 8.w),
          CustomText(
            title: label,
            textSize: 12.sp,
            textColor: isMet ? ConstColor.titleColor : ConstColor.bodyColor,
          ),
        ],
      ),
    );
  }
}