// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/model/property_detail_model.dart
import 'package:flutter/material.dart';
class UnitDetailModel {
  final String id;
  final String label;
  final String floorLabel;
  final String bedBathLabel;
  final double rent;
  final bool isOccupied;
  final String? photoUrl;
  final String? tenantId;

  const UnitDetailModel({
    required this.id,
    required this.label,
    required this.floorLabel,
    required this.bedBathLabel,
    required this.rent,
    required this.isOccupied,
    this.photoUrl,
    this.tenantId,
  });
}

class FloorGroupModel {
  final String floorLabel;
  final List<UnitDetailModel> units;
  const FloorGroupModel({required this.floorLabel, required this.units});
}

class PropertyTenantModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final String unitLabel;
  final double rent;
  final bool isActive;

  const PropertyTenantModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.unitLabel,
    required this.rent,
    this.isActive = true,
  });
}

class TenantDetailModel {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final bool isActive;
  final String unitLabel;
  final String propertyName;
  final String dateOfBirth;
  final String nid;
  final String email;
  final String phone;
  final String emergencyContact;
  final String address;
  final String nidProofFileName;
  final String depositSummary;
  final String keysSummary;
  final String buildingInfoSummary;
  final int documentsCount;
  final String? latestNoteSummary;
  final String? latestNoteDateLabel;
  final LeaseAgreementModel leaseAgreement;
  final DepositInfoModel deposit;
  final PaymentsHistoryModel paymentsHistory;
  final List<KeySetModel> keySets;
  final List<TenantNoteModel> notes;
  final List<TenantDocumentModel> documents;

  const TenantDetailModel({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.isActive = true,
    required this.unitLabel,
    required this.propertyName,
    required this.dateOfBirth,
    required this.nid,
    required this.email,
    required this.phone,
    required this.emergencyContact,
    required this.address,
    required this.nidProofFileName,
    required this.depositSummary,
    required this.keysSummary,
    required this.buildingInfoSummary,
    required this.documentsCount,
    this.latestNoteSummary,
    this.latestNoteDateLabel,
    required this.leaseAgreement,
    required this.deposit,
    required this.paymentsHistory,
    required this.keySets,
    required this.notes,
    required this.documents,
  });
}

class KeySetModel {
  final String id;
  final String keyType;
  final int quantity;
  final String location;
  final String heldBy;
  const KeySetModel({required this.id, required this.keyType, required this.quantity, required this.location, required this.heldBy});
}

class TenantNoteModel {
  final String id;
  final String text;
  final String dateLabel;
  final String authorLabel;
  const TenantNoteModel({required this.id, required this.text, required this.dateLabel, required this.authorLabel});
}

class TenantDocumentModel {
  final String id;
  final String fileName;
  final String dateLabel;
  final String categoryLabel;
  const TenantDocumentModel({required this.id, required this.fileName, required this.dateLabel, required this.categoryLabel});
}

class PaymentHistoryEntryModel {
  final String label;
  final String dueDateLabel;
  final double amount;
  final bool isPaid;
  const PaymentHistoryEntryModel({required this.label, required this.dueDateLabel, required this.amount, this.isPaid = true});
}

class DepositInfoModel {
  final double monthlyRent;
  final double dueCharges;
  final String nextMonthLabel;
  final double nextMonthAmount;
  final double depositAmount;
  final String moveInDate;
  final String scheme;
  final String leaseEndsDate;
  const DepositInfoModel({
    required this.monthlyRent, required this.dueCharges, required this.nextMonthLabel, required this.nextMonthAmount,
    required this.depositAmount, required this.moveInDate, required this.scheme, required this.leaseEndsDate,
  });
}

class PaymentsHistoryModel {
  final double lastPayment;
  final String lastPaymentDate;
  final double nextDue;
  final String nextDueDate;
  final double depositHeld;
  final double advancePaid;
  final List<PaymentHistoryEntryModel> stillDue;
  final List<PaymentHistoryEntryModel> monthly;
  const PaymentsHistoryModel({
    required this.lastPayment, required this.lastPaymentDate, required this.nextDue, required this.nextDueDate,
    required this.depositHeld, required this.advancePaid, required this.stillDue, required this.monthly,
  });
}

class LeaseAgreementModel {
  final String documentName;
  final String issuedDate;
  final String landlordName;
  const LeaseAgreementModel({required this.documentName, required this.issuedDate, required this.landlordName});
}

enum DepositScheme { myDeposits, dps, tds, notYetRegistered }

extension DepositSchemeX on DepositScheme {
  String get label => switch (this) {
    DepositScheme.myDeposits => 'MyDeposits',
    DepositScheme.dps => 'DPS',
    DepositScheme.tds => 'TDS',
    DepositScheme.notYetRegistered => 'Not yet registered',
  };
}

enum UploadDocCategory { tenancyAgreement, gasSafety, electrical, epc, depositProtection, howToRent, other }

extension UploadDocCategoryX on UploadDocCategory {
  String get label => switch (this) {
    UploadDocCategory.tenancyAgreement => 'Tenancy agreement',
    UploadDocCategory.gasSafety => 'Gas safety (CP12)',
    UploadDocCategory.electrical => 'Electrical (EICR)',
    UploadDocCategory.epc => 'EPC certificate',
    UploadDocCategory.depositProtection => 'Deposit protection',
    UploadDocCategory.howToRent => 'How to Rent guide',
    UploadDocCategory.other => 'Other file',
  };

  IconData get icon => switch (this) {
    UploadDocCategory.tenancyAgreement => Icons.description_outlined,
    UploadDocCategory.gasSafety => Icons.local_fire_department_outlined,
    UploadDocCategory.electrical => Icons.bolt_outlined,
    UploadDocCategory.epc => Icons.eco_outlined,
    UploadDocCategory.depositProtection => Icons.shield_outlined,
    UploadDocCategory.howToRent => Icons.menu_book_outlined,
    UploadDocCategory.other => Icons.insert_drive_file_outlined,
  };

  Color get iconColor => switch (this) {
    UploadDocCategory.tenancyAgreement => const Color(0xFF1A73E8),
    UploadDocCategory.gasSafety => const Color(0xFFD93025),
    UploadDocCategory.electrical => const Color(0xFFF57C00),
    UploadDocCategory.epc => const Color(0xFF1E8E3E),
    UploadDocCategory.depositProtection => const Color(0xFF1E8E3E),
    UploadDocCategory.howToRent => const Color(0xFF1A73E8),
    UploadDocCategory.other => const Color(0xFF64748B),
  };

  Color get bgColor => switch (this) {
    UploadDocCategory.tenancyAgreement => const Color(0xFFEBF3FF),
    UploadDocCategory.gasSafety => const Color(0xFFFDE8E8),
    UploadDocCategory.electrical => const Color(0xFFFEF3E8),
    UploadDocCategory.epc => const Color(0xFFE6F4EA),
    UploadDocCategory.depositProtection => const Color(0xFFE6F4EA),
    UploadDocCategory.howToRent => const Color(0xFFE8F0FE),
    UploadDocCategory.other => const Color(0xFFF1F5F9),
  };
}