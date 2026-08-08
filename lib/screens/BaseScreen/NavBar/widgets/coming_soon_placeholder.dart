import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';

/// Temporary placeholder for nav tabs whose real screens aren't built yet.
class ComingSoonPlaceholder extends StatelessWidget {
  final String label;

  const ComingSoonPlaceholder({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.construction_rounded, size: 40.sp, color: ConstColor.bodyColor),
            SizedBox(height: 12.h),
            CustomText(
              title: '$label — Coming Soon',
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              textColor: ConstColor.titleColor,
            ),
          ],
        ),
      ),
    );
  }
}