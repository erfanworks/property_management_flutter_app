import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';

class ChatMessageModel {
  final String text;
  final String time;
  final bool isMe;
  final String? status;

  const ChatMessageModel({
    required this.text,
    required this.time,
    this.isMe = false,
    this.status,
  });
}

/// Reused for every message row inside Chat Detail screen.
class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: message.isMe ? ConstColor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title: message.text,
              textSize: 13.sp,
              textColor: message.isMe ? Colors.white : ConstColor.titleColor,
            ),
            SizedBox(height: 4.h),
            CustomText(
              title: message.status != null ? "${message.time} · ${message.status}" : message.time,
              textSize: 10.sp,
              textColor: message.isMe ? Colors.white.withAlpha(200) : ConstColor.bodyColor,
            ),
          ],
        ),
      ),
    );
  }
}