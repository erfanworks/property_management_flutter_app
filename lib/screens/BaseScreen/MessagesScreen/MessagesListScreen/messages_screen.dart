import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';
import '../Widget/conversation_tile.dart';
import 'Controller/messages_list_screen_controller.dart';

class MessagesListScreen extends StatelessWidget {
  const MessagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessagesListScreenController>(
      init: MessagesListScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  controller.isContractor
                      ? _ContractorHeader(onCompose: controller.onComposeNewMessage)
                      : Padding(
                    padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: 'Messages',
                          textSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.titleColor,
                        ),
                        InkWell(
                          onTap: controller.onComposeNewMessage,
                          child: Icon(Icons.edit_square, size: 22.sp, color: ConstColor.titleColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _SearchBar(onChanged: controller.onSearchChanged),
                  SizedBox(height: 4.h),
                  Expanded(
                    child: Obx(
                          () => ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.conversations.length,
                        itemBuilder: (_, index) {
                          final conversation = controller.conversations[index];
                          return ConversationTile(
                            conversation: conversation,
                            onTap: () => controller.onOpenConversation(conversation),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ContractorHeader extends StatelessWidget {
  final VoidCallback onCompose;

  const _ContractorHeader({required this.onCompose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu_rounded, size: 24.sp, color: ConstColor.titleColor), // TODO: wire drawer later
              InkWell(
                onTap: onCompose,
                child: Icon(Icons.edit_square, size: 22.sp, color: ConstColor.titleColor),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CustomText(
            title: 'Messages',
            textSize: 22.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.titleColor,
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, size: 20.sp, color: ConstColor.bodyColor),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: TextStyle(fontSize: 14.sp, color: ConstColor.titleColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search messages...',
                hintStyle: TextStyle(fontSize: 14.sp, color: ConstColor.bodyColor),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}