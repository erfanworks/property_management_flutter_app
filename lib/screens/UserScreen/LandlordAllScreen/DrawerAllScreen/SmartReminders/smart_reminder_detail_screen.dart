// lib/screens/UserScreen/LandlordAllScreen/SmartReminders/smart_reminder_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/DetailRow/detail_row.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'controller/smart_reminders_controller.dart';

class SmartReminderDetailScreen extends GetView<SmartRemindersController> {
  const SmartReminderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final r = controller.selectedReminder.value;
      if (r == null) return const Scaffold(body: SizedBox.shrink());
      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: r.title),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                children: [
                  DetailRow(label: ConstString.certificateLabel, value: r.title),
                  DetailRow(label: ConstString.property, value: r.propertyName),
                  DetailRow(label: ConstString.flatLabel, value: r.flatLabel ?? '—'),
                  DetailRow(label: ConstString.expiresLabel, value: r.expiryDateLabel),
                  DetailRow(label: ConstString.statusLabel, value: r.daysLateLabel, isLast: true),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}