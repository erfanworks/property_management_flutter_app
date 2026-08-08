import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';
import 'chat_avatar.dart';
import 'conversation_tile.dart';

class NewMessageSheet extends StatelessWidget {
  final List<ConversationModel> conversations;
  final ValueChanged<ConversationModel> onSelect;

  const NewMessageSheet({super.key, required this.conversations, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: 'New message',
              textSize: 18.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.titleColor,
            ),
            SizedBox(height: 4.h),
            CustomText(title: 'Choose who to message', textSize: 12.sp, textColor: ConstColor.bodyColor),
            SizedBox(height: 12.h),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 0.5.sh),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: conversations.length,
                separatorBuilder: (_, __) => Divider(height: 1, color: ConstColor.bodyColor.withAlpha(30)),
                itemBuilder: (_, index) {
                  final c = conversations[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ChatAvatar(imageUrl: c.avatarUrl, isOnline: c.isOnline, isGroup: c.isGroup, size: 40),
                    title: Row(
                      children: [
                        Flexible(
                          child: CustomText(
                            title: c.title,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            textColor: ConstColor.titleColor,
                          ),
                        ),
                        if (c.tag != null) ...[
                          SizedBox(width: 6.w),
                          CustomText(title: '· ${c.tag}', textSize: 12.sp, textColor: ConstColor.primaryColor),
                        ],
                      ],
                    ),
                    subtitle: CustomText(
                      title: c.subtitleLines.length > 1 ? c.subtitleLines[1] : c.subtitleLines.first,
                      textSize: 12.sp,
                      textColor: ConstColor.bodyColor,
                    ),
                    trailing: Icon(Icons.chevron_right_rounded, color: ConstColor.bodyColor),
                    onTap: () {
                      Get.back();
                      onSelect(c);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
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