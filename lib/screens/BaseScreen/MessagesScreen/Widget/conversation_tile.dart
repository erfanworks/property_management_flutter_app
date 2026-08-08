import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';
import 'chat_avatar.dart';

class ConversationModel {
  final String id;
  final String? avatarUrl;
  final bool isOnline;
  final bool isGroup;
  final String title;
  final String? tag;
  final List<String> subtitleLines;
  final String timestamp;
  final int unreadCount;

  const ConversationModel({
    required this.id,
    this.avatarUrl,
    this.isOnline = false,
    this.isGroup = false,
    required this.title,
    this.tag,
    required this.subtitleLines,
    this.timestamp = '',
    this.unreadCount = 0,
  });
}

/// Reused for every row in Messages list (Landlord/Tenant + Contractor + New-message picker).
class ConversationTile extends StatelessWidget {
  final ConversationModel conversation;
  final VoidCallback onTap;

  const ConversationTile({super.key, required this.conversation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatAvatar(imageUrl: conversation.avatarUrl, isOnline: conversation.isOnline, isGroup: conversation.isGroup),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: CustomText(
                          title: conversation.title,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.titleColor,
                          maxLine: 1,
                        ),
                      ),
                      if (conversation.tag != null) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: ConstColor.primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: CustomText(
                            title: conversation.tag!,
                            textSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            textColor: ConstColor.primaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 3.h),
                  for (final line in conversation.subtitleLines)
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: CustomText(title: line, textSize: 12.sp, textColor: ConstColor.bodyColor, maxLine: 1),
                    ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(title: conversation.timestamp, textSize: 11.sp, textColor: ConstColor.bodyColor),
                SizedBox(height: 6.h),
                if (conversation.unreadCount > 0)
                  Container(
                    width: 18.w,
                    height: 18.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: ConstColor.primaryColor, shape: BoxShape.circle),
                    child: CustomText(
                      title: '${conversation.unreadCount}',
                      textSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}