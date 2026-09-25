// lib/common_widget/icon_badge/custom_icon_badge.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconBadge extends StatelessWidget {
  const CustomIconBadge({
    super.key,
    this.icon,
    this.svgPath,
    required this.iconColor,
    required this.backgroundColor,
    this.size = 44,
    this.iconSize = 20,
    this.isCircle = true,
    this.borderRadius = 12,
    this.border,
  }) : assert(icon != null || svgPath != null, 'Provide either icon or svgPath');

  final IconData? icon;
  final String? svgPath;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double iconSize;
  final bool isCircle;
  final double borderRadius;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(borderRadius.r),
        border: border,
      ),
      child: Center(
        child: svgPath != null
            ? SvgPicture.asset(
          svgPath!,
          width: iconSize.sp,
          height: iconSize.sp,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        )
            : Icon(icon, color: iconColor, size: iconSize.sp),
      ),
    );
  }
}
