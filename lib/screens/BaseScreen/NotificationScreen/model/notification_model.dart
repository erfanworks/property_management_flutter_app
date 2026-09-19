// lib/screens/UserScreen/NotificationScreen/model/notification_model.dart
import 'package:flutter/material.dart';

class NotificationItemModel {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;

  const NotificationItemModel({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isUnread = false,
  });
}

class NotificationGroupModel {
  final String sectionLabel;
  final List<NotificationItemModel> items;

  const NotificationGroupModel({required this.sectionLabel, required this.items});
}