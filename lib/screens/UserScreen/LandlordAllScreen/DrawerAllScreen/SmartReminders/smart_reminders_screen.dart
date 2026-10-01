// lib/screens/UserScreen/LandlordAllScreen/SmartReminders/smart_reminders_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/smart_reminders_controller.dart';
import 'model/smart_reminder_model.dart';

class SmartRemindersScreen extends GetView<SmartRemindersController> {
  const SmartRemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.smartReminders,
        actions: [AppBarTextAction(label: ConstString.addLabel, icon: Icons.add_rounded, onTap: controller.openAdd)],
      ),
      body: Obx(
            () => Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: CustomDropdownField<String>(
                value: controller.selectedProperty.value,
                hintText: '${ConstString.allProperties} (${controller.reminders.length})',
                items: controller.properties.map((p) => DropdownMenuItem(value: p, child: CustomText(title: p, textSize: 14.sp))).toList(),
                onChanged: controller.selectProperty,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(child: _Tab(label: ConstString.all, count: controller.reminders.length, isSelected: controller.selectedTabIndex.value == 0, onTap: () => controller.selectTab(0))),
                  SizedBox(width: 8.w),
                  Expanded(child: _Tab(label: ConstString.overdue, count: controller.overdueCount, isSelected: controller.selectedTabIndex.value == 1, onTap: () => controller.selectTab(1))),
                  SizedBox(width: 8.w),
                  Expanded(child: _Tab(label: ConstString.dueSoon, count: controller.dueSoonCount, isSelected: controller.selectedTabIndex.value == 2, onTap: () => controller.selectTab(2))),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.filteredReminders.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final r = controller.filteredReminders[index];
                  return _ReminderTile(data: r, onTap: () => controller.openDetail(r));
                },
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.label, required this.count, required this.isSelected, required this.onTap});
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(color: isSelected ? ConstColor.primaryColor : Colors.white, borderRadius: BorderRadius.circular(20.r), border: Border.all(color: isSelected ? ConstColor.primaryColor : ConstColor.dividerColor)),
        alignment: Alignment.center,
        child: CustomText(title: '$label $count', textSize: 12.sp, fontWeight: FontWeight.w600, textColor: isSelected ? Colors.white : ConstColor.titleColor),
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({required this.data, required this.onTap});
  final SmartReminderModel data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isOverdue = data.category == ReminderCategory.overdue;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          children: [
            CustomIconBadge(icon: Icons.notifications_none_rounded, iconColor: ConstColor.primaryColor, backgroundColor: ConstColor.infoBg, size: 36),
            SizedBox(width: 10.w),
            Expanded(child: CustomText(title: data.title, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: isOverdue ? ConstColor.errorBg : ConstColor.contractorIconBg, borderRadius: BorderRadius.circular(20.r)),
              child: CustomText(title: data.daysLateLabel, textSize: 11.sp, fontWeight: FontWeight.w600, textColor: isOverdue ? ConstColor.errorColor : ConstColor.contractorIconColor),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.chevron_right_rounded, size: 18.sp, color: ConstColor.bodyColor),
          ],
        ),
      ),
    );
  }
}