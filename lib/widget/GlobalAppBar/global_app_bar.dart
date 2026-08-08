import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/const_color.dart';
import '../text/custom_text.dart';

//=========Global App Bar=========//

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlobalAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.showBack = true,
    this.onBack,
    this.leading,
    this.centerWidget,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 0,
    this.bottom,
  });

  /// Simple left-aligned title
  final String? title;

  /// Optional subtitle below title
  final String? subtitle;

  /// Show/hide back button (rounded square)
  final bool showBack;

  /// Custom back handler — defaults to Get.back()
  final VoidCallback? onBack;

  /// Fully custom leading widget (replaces back button)
  final Widget? leading;

  /// Center widget (logo + tagline, avatar row, etc.)
  final Widget? centerWidget;

  /// Right-side actions
  final List<Widget>? actions;

  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;

  /// Extra widget below the bar (e.g. tab bar, divider)
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: elevation,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: centerWidget != null,
      bottom: bottom,

      //=========Leading=========//
      leading: leading ??
          (showBack
              ? Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: _BackButton(onBack: onBack),
          )
              : null),
      leadingWidth: showBack || leading != null ? 56.w : 0,

      //=========Title=========//
      title: centerWidget ??
          (title != null
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                title: title!,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                textColor: titleColor ?? ConstColor.titleColor,
                maxLine: 1,
              ),
              if (subtitle != null) ...[
                SizedBox(height: 2.h),
                CustomText(
                  title: subtitle!,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  textColor: ConstColor.titleColor,
                  maxLine: 1,
                ),
              ],
            ],
          )
              : null),

      //=========Actions=========//
      actions: actions != null
          ? [
        ...actions!,
        SizedBox(width: 8.w),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );
}

//=========Back Button=========//

class _BackButton extends StatelessWidget {
  const _BackButton({this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack ?? () => Get.back(),
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(18),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16.sp,
          color: ConstColor.titleColor,
        ),
      ),
    );
  }
}

//=========Notification Bell Action=========//

class AppBarBell extends StatelessWidget {
  const AppBarBell({
    super.key,
    required this.onTap,
    this.badgeCount = 0,
  });

  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(Icons.notifications_outlined,
              size: 26.sp, color: ConstColor.titleColor),
          if (badgeCount > 0)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 16.r,
                height: 16.r,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomText(
                    title: badgeCount > 9 ? '9+' : '$badgeCount',
                    textSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

//=========Avatar Action=========//

class AppBarAvatar extends StatelessWidget {
  const AppBarAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    required this.onTap,
  });

  final String? imageUrl;
  final String? initials;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: ConstColor.primaryColor,
          shape: BoxShape.circle,
          image: imageUrl != null
              ? DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: imageUrl == null
            ? Center(
          child: CustomText(
            title: initials ?? '',
            textSize: 13.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.primaryColor,
          ),
        )
            : null,
      ),
    );
  }
}

//=========Text Action (Mark all read, Add Property etc.)=========//

class AppBarTextAction extends StatelessWidget {
  const AppBarTextAction({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16.sp, color: color ?? ConstColor.primaryColor),
            SizedBox(width: 4.w),
          ],
          CustomText(
            title: label,
            textSize: 14.sp,
            fontWeight: FontWeight.w500,
            textColor: color ?? ConstColor.primaryColor,
          ),
        ],
      ),
    );
  }
}