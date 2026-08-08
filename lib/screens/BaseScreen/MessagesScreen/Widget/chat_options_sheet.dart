import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';

/// Reused by Chat Detail screen (all roles) — 3-dot "more" menu.
class ChatOptionsSheet extends StatelessWidget {
  final VoidCallback onMute;
  final VoidCallback onClearMessages;
  final VoidCallback onDeleteChat;

  const ChatOptionsSheet({
    super.key,
    required this.onMute,
    required this.onClearMessages,
    required this.onDeleteChat,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: 'Chat options',
              textSize: 18.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.titleColor,
            ),
            SizedBox(height: 16.h),
            _SectionLabel(label: 'NOTIFICATIONS'),
            SizedBox(height: 8.h),
            _OptionTile(
              icon: Icons.notifications_off_outlined,
              iconBg: const Color(0xFFE0E7FF),
              iconColor: ConstColor.primaryColor,
              title: 'Mute notifications',
              subtitle: 'Silence alerts from this chat',
              onTap: onMute,
            ),
            SizedBox(height: 16.h),
            _SectionLabel(label: 'MANAGE'),
            SizedBox(height: 8.h),
            _OptionTile(
              icon: Icons.auto_fix_high_outlined,
              iconBg: const Color(0xFFE0E7FF),
              iconColor: ConstColor.primaryColor,
              title: 'Clear messages for me',
              subtitle: 'Hide message history on this device',
              onTap: onClearMessages,
            ),
            SizedBox(height: 8.h),
            _OptionTile(
              icon: Icons.delete_outline_rounded,
              iconBg: const Color(0xFFFEE2E2),
              iconColor: Colors.red,
              title: 'Delete chat',
              titleColor: Colors.red,
              subtitle: 'Remove from inbox and clear messages',
              onTap: onDeleteChat,
            ),
            SizedBox(height: 16.h),
            Center(
              child: TextButton(
                onPressed: () => Get.back(),
                child: CustomText(
                  title: 'Cancel',
                  textSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.titleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return CustomText(title: label, textSize: 11.sp, fontWeight: FontWeight.w700, textColor: ConstColor.bodyColor);
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final Color? titleColor;
  final String subtitle;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    this.titleColor,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: ConstColor.bodyColor.withAlpha(40)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10.r)),
              child: Icon(icon, size: 18.sp, color: iconColor),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textColor: titleColor ?? ConstColor.titleColor,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(title: subtitle, textSize: 11.sp, textColor: ConstColor.bodyColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}