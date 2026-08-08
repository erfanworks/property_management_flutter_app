import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../Widget/chat_avatar.dart';
import '../Widget/chat_bubble.dart';
import 'Controller/chat_detail_screen_controller.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatDetailScreenController>(
      init: ChatDetailScreenController(),
      builder: (controller) {
        final conversation = controller.conversation;
        final String? addressLine =
        conversation.subtitleLines.length > 1 ? conversation.subtitleLines[1] : null;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: GlobalAppBar(
            centerWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChatAvatar(isOnline: conversation.isOnline, isGroup: conversation.isGroup, size: 36),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: conversation.title,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      textColor: ConstColor.titleColor,
                    ),
                    Row(
                      children: [
                        if (conversation.isOnline) ...[
                          Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
                          ),
                          SizedBox(width: 4.w),
                          CustomText(title: 'Online', textSize: 11.sp, textColor: const Color(0xFF22C55E)),
                          if (addressLine != null)
                            CustomText(title: ' · ', textSize: 11.sp, textColor: ConstColor.bodyColor),
                        ],
                        if (addressLine != null)
                          CustomText(title: addressLine, textSize: 11.sp, textColor: ConstColor.bodyColor),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              SizedBox(width: 8.w),
              InkWell(
                onTap: controller.onChatOptions,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.more_vert_rounded, size: 18.sp, color: ConstColor.titleColor),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Obx(
                      () => ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    children: [
                      Center(
                        child: CustomText(title: 'Today', textSize: 11.sp, textColor: ConstColor.bodyColor),
                      ),
                      SizedBox(height: 12.h),
                      for (final message in controller.messages) ChatBubble(message: message),
                    ],
                  ),
                ),
              ),
              _MessageInputBar(controller: controller.messageController, onSend: controller.onSend),
            ],
          ),
        );
      },
    );
  }
}

class _MessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _MessageInputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Icon(Icons.attach_file_rounded, size: 22.sp, color: ConstColor.bodyColor),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: TextField(
                  controller: controller,
                  style: TextStyle(fontSize: 14.sp, color: ConstColor.titleColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(fontSize: 14.sp, color: ConstColor.bodyColor),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            InkWell(
              onTap: onSend,
              child: Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: ConstColor.primaryColor, shape: BoxShape.circle),
                child: Icon(Icons.send_rounded, size: 18.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}