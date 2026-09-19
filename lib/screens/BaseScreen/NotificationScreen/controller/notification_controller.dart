// lib/screens/UserScreen/NotificationScreen/controller/notification_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final selectedTabIndex = 0.obs; // 0 = All, 1 = Unread
  final RxList<NotificationGroupModel> groups = <NotificationGroupModel>[].obs;

  List<NotificationGroupModel> get filteredGroups {
    if (selectedTabIndex.value == 0) return groups;
    return groups
        .map((g) => NotificationGroupModel(
      sectionLabel: g.sectionLabel,
      items: g.items.where((i) => i.isUnread).toList(),
    ))
        .where((g) => g.items.isNotEmpty)
        .toList();
  }

  int get unreadCount => groups.fold(0, (sum, g) => sum + g.items.where((i) => i.isUnread).length);

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void selectTab(int index) => selectedTabIndex.value = index;

  void markAllAsRead() {
    groups.value = groups
        .map((g) => NotificationGroupModel(
      sectionLabel: g.sectionLabel,
      items: g.items
          .map((i) => NotificationItemModel(
        icon: i.icon,
        iconColor: i.iconColor,
        iconBg: i.iconBg,
        title: i.title,
        subtitle: i.subtitle,
        time: i.time,
        isUnread: false,
      ))
          .toList(),
    ))
        .toList();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchNotifications() async {
    groups.value = [
      NotificationGroupModel(
        sectionLabel: ConstString.today,
        items: [
          NotificationItemModel(
            icon: Icons.build_rounded,
            iconColor: ConstColor.errorColor,
            iconBg: ConstColor.errorBg,
            title: 'Maintenance completed',
            subtitle: 'Kitchen sink fixed at 12 Park Lane',
            time: '2h ago',
            isUnread: true,
          ),
          NotificationItemModel(
            icon: Icons.local_fire_department_rounded,
            iconColor: ConstColor.contractorIconColor,
            iconBg: ConstColor.contractorIconBg,
            title: 'Compliance alert',
            subtitle: 'Gas certificate expires in 3 days',
            time: '5h ago',
            isUnread: true,
          ),
        ],
      ),
      NotificationGroupModel(
        sectionLabel: ConstString.earlier,
        items: [
          NotificationItemModel(
            icon: Icons.account_balance_wallet_rounded,
            iconColor: ConstColor.tenantIconColor,
            iconBg: ConstColor.tenantIconBg,
            title: 'Rent received',
            subtitle: '£2,450 from Sarah Johnson',
            time: '1d ago',
          ),
          NotificationItemModel(
            icon: Icons.assignment_rounded,
            iconColor: ConstColor.primaryColor,
            iconBg: ConstColor.infoBg,
            title: 'Inspection scheduled',
            subtitle: '45 Queens Rd · Feb 28',
            time: '2d ago',
          ),
        ],
      ),
    ];
  }
}