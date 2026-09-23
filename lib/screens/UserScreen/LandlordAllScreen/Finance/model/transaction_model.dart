// lib/screens/UserScreen/LandlordAllScreen/Finance/model/transaction_model.dart
import 'package:flutter/material.dart';
import '../../../../../constant/const_color.dart';

enum TransactionStatus { paid, due, overdue, pending }
enum TransactionCategory { rent, charge }

extension TransactionStatusX on TransactionStatus {
  String get label => switch (this) {
    TransactionStatus.paid => 'Paid',
    TransactionStatus.due => 'Due',
    TransactionStatus.overdue => 'Overdue',
    TransactionStatus.pending => 'Pending',
  };

  Color get color => switch (this) {
    TransactionStatus.paid => ConstColor.tenantIconColor,
    TransactionStatus.due => ConstColor.contractorIconColor,
    TransactionStatus.overdue => ConstColor.errorColor,
    TransactionStatus.pending => ConstColor.primaryColor,
  };

  Color get bg => switch (this) {
    TransactionStatus.paid => ConstColor.tenantIconBg,
    TransactionStatus.due => ConstColor.contractorIconBg,
    TransactionStatus.overdue => ConstColor.errorBg,
    TransactionStatus.pending => ConstColor.infoBg,
  };
}

class TransactionModel {
  final String id;
  final String tenantName;
  final String? tenantAvatarUrl;
  final String propertyName;
  final String unitLabel;
  final String typeLabel;
  final double amount;
  final String dueDateLabel;
  final TransactionStatus status;
  final TransactionCategory category;
  final String? extraNoteLabel;
  final String invoiceNumber;
  final String? paidOnLabel;
  final String? paymentMethodLabel;
  final String? referenceLabel;

  const TransactionModel({
    required this.id,
    required this.tenantName,
    this.tenantAvatarUrl,
    required this.propertyName,
    required this.unitLabel,
    required this.typeLabel,
    required this.amount,
    required this.dueDateLabel,
    required this.status,
    required this.category,
    this.extraNoteLabel,
    required this.invoiceNumber,
    this.paidOnLabel,
    this.paymentMethodLabel,
    this.referenceLabel,
  });

  TransactionModel copyWith({TransactionStatus? status, String? paidOnLabel, String? paymentMethodLabel, String? referenceLabel}) {
    return TransactionModel(
      id: id, tenantName: tenantName, tenantAvatarUrl: tenantAvatarUrl, propertyName: propertyName,
      unitLabel: unitLabel, typeLabel: typeLabel, amount: amount, dueDateLabel: dueDateLabel,
      status: status ?? this.status, category: category, extraNoteLabel: extraNoteLabel, invoiceNumber: invoiceNumber,
      paidOnLabel: paidOnLabel ?? this.paidOnLabel,
      paymentMethodLabel: paymentMethodLabel ?? this.paymentMethodLabel,
      referenceLabel: referenceLabel ?? this.referenceLabel,
    );
  }
}