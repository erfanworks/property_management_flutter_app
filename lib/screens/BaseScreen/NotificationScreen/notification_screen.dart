import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constant/const_color.dart';
import '../../../constant/const_string.dart';
import '../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../widget/text/custom_text.dart';
import 'controller/notification_controller.dart';
import 'model/notification_model.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.notifications,
        actions: [
          AppBarTextAction(label: ConstString.markAllRead, onTap: controller.markAllAsRead),
        ],
      ),
      body: Column(
        children: [
          Obx(() => _NotificationTabBar(
            selectedIndex: controller.selectedTabIndex.value,
            unreadCount: controller.unreadCount,
            onChanged: controller.selectTab,
          )),
          Expanded(
            child: Obx(() {
              final groups = controller.filteredGroups;
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h, top: index == 0 ? 0 : 16.h),
                        child: CustomText(
                          title: group.sectionLabel.toUpperCase(),
                          textSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          textColor: ConstColor.bodyColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                      ...group.items.map((item) => Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: _NotificationTile(data: item),
                      )),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _NotificationTabBar extends StatelessWidget {
  const _NotificationTabBar({required this.selectedIndex, required this.unreadCount, required this.onChanged});
  final int selectedIndex;
  final int unreadCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: ConstColor.dividerColor))),
      child: Row(
        children: [
          _TabItem(label: ConstString.all, isSelected: selectedIndex == 0, onTap: () => onChanged(0)),
          SizedBox(width: 24.w),
          _TabItem(label: ConstString.unread, isSelected: selectedIndex == 1, onTap: () => onChanged(1), badgeCount: unreadCount),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({required this.label, required this.isSelected, required this.onTap, this.badgeCount = 0});
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          children: [
            Row(
              children: [
                CustomText(title: label, textSize: 14.sp, fontWeight: FontWeight.w600, textColor: isSelected ? ConstColor.primaryColor : ConstColor.bodyColor),
                if (badgeCount > 0) ...[
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    decoration: BoxDecoration(color: ConstColor.errorColor, borderRadius: BorderRadius.circular(10.r)),
                    child: CustomText(title: '$badgeCount', textSize: 10.sp, fontWeight: FontWeight.w700, textColor: Colors.white),
                  ),
                ],
              ],
            ),
            SizedBox(height: 6.h),
            Container(height: 2.h, width: 24.w, color: isSelected ? ConstColor.primaryColor : Colors.transparent),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.data});
  final NotificationItemModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconBadge(icon: data.icon, iconColor: data.iconColor, backgroundColor: data.iconBg, size: 42, isCircle: false, borderRadius: 12),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title: data.title, textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor, maxLine: 1),
                SizedBox(height: 2.h),
                CustomText(title: data.subtitle, textSize: 12.sp, textColor: ConstColor.bodyColor, maxLine: 2),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(title: data.time, textSize: 11.sp, textColor: ConstColor.bodyColor),
              if (data.isUnread) ...[
                SizedBox(height: 6.h),
                Container(width: 6.r, height: 6.r, decoration: BoxDecoration(color: ConstColor.primaryColor, shape: BoxShape.circle)),
              ],
            ],
          ),
        ],
      ),
    );
  }
}