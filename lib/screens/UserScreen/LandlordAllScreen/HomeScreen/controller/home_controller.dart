// lib/screens/UserScreen/HomeScreen/controller/home_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../model/home_dashboard_model.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;

  final Rx<IncomeOverviewModel> incomeOverview = const IncomeOverviewModel(
    monthlyIncome: 0,
    occupiedPropertiesCount: 0,
    totalProperties: 0,
    totalTenants: 0,
    occupiedPercentage: 0,
  ).obs;

  final Rx<FinancialOverviewModel> financialOverview = const FinancialOverviewModel(
    collectedPercentage: 0,
    paidAmount: 0,
    pendingAmount: 0,
    overdueAmount: 0,
  ).obs;

  final RxList<AttentionItemModel> attentionItems = <AttentionItemModel>[].obs;
  final RxList<ReminderItemModel> reminders = <ReminderItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchDashboard() async {
    isLoading.value = true;

    incomeOverview.value = const IncomeOverviewModel(
      monthlyIncome: 8350,
      occupiedPropertiesCount: 3,
      totalProperties: 4,
      totalTenants: 3,
      occupiedPercentage: 75,
    );

    financialOverview.value = const FinancialOverviewModel(
      collectedPercentage: 0,
      paidAmount: 0,
      pendingAmount: 4485,
      overdueAmount: 1850,
    );

    attentionItems.value = [
      AttentionItemModel(
        icon: Icons.receipt_long_rounded,
        iconColor: ConstColor.errorColor,
        iconBg: ConstColor.errorBg,
        title: '1 overdue rent',
        subtitle: '£1,850 to collect',
      ),
      AttentionItemModel(
        icon: Icons.build_rounded,
        iconColor: ConstColor.contractorIconColor,
        iconBg: ConstColor.contractorIconBg,
        title: '3 tenant reports need contractor',
        subtitle: 'Damp patch in bedroom, Bathroom basin cracked...',
      ),
    ];

    reminders.value = [
      ReminderItemModel(
        icon: Icons.local_fire_department_rounded,
        iconColor: ConstColor.errorColor,
        iconBg: ConstColor.errorBg,
        title: 'Gas Certificate Expiry',
        subtitle: '45 Queens Road · 342 days overdue',
      ),
      ReminderItemModel(
        icon: Icons.local_fire_department_rounded,
        iconColor: ConstColor.errorColor,
        iconBg: ConstColor.errorBg,
        title: 'Gas Certificate Expiry',
        subtitle: '88 King Street · 272 days overdue',
      ),
    ];

    isLoading.value = false;
  }
}