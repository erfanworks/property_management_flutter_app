// lib/screens/UserScreen/LandlordAllScreen/Finance/model/finance_summary_model.dart
import 'package:flutter/material.dart';

enum FinanceTab { all, rent, charges }

extension FinanceTabX on FinanceTab {
  String get label => switch (this) {
    FinanceTab.all => 'All',
    FinanceTab.rent => 'Rent',
    FinanceTab.charges => 'Charges',
  };
}

class FinanceStatItem {
  final String label;
  final String value;
  final Color color;
  final Color bg;
  const FinanceStatItem({required this.label, required this.value, required this.color, required this.bg});
}

class FinanceSummaryModel {
  final double collectedAmount;
  final double expectedAmount;
  final int collectedPercentage;
  final int paidCount;
  final int outstandingCount;
  final List<FinanceStatItem> stats;

  const FinanceSummaryModel({
    required this.collectedAmount,
    required this.expectedAmount,
    required this.collectedPercentage,
    required this.paidCount,
    required this.outstandingCount,
    required this.stats,
  });
}