// lib/screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/HomeScreen/model/home_dashboard_model.dart
import 'package:flutter/material.dart';

class IncomeOverviewModel {
  final double monthlyIncome;
  final int occupiedPropertiesCount;
  final int totalProperties;
  final int totalTenants;
  final int occupiedPercentage;

  const IncomeOverviewModel({
    required this.monthlyIncome,
    required this.occupiedPropertiesCount,
    required this.totalProperties,
    required this.totalTenants,
    required this.occupiedPercentage,
  });
}

class FinancialOverviewModel {
  final int collectedPercentage;
  final double paidAmount;
  final double pendingAmount;
  final double overdueAmount;

  const FinancialOverviewModel({
    required this.collectedPercentage,
    required this.paidAmount,
    required this.pendingAmount,
    required this.overdueAmount,
  });
}

class AttentionItemModel {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  const AttentionItemModel({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });
}

class ReminderItemModel {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  const ReminderItemModel({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });
}