// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/model/records_model.dart
import 'package:flutter/material.dart';

class RecordCategoryModel {
  final String id;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  const RecordCategoryModel({
    required this.id,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });
}

enum ComplianceType { gasSafety, electricalEicr, energyPerformance, landlordInsurance, depositProtection, propertyLicence, otherDocuments }

extension ComplianceTypeX on ComplianceType {
  String get label => switch (this) {
    ComplianceType.gasSafety => 'Gas Safety (CP12)',
    ComplianceType.electricalEicr => 'Electrical (EICR)',
    ComplianceType.energyPerformance => 'Energy Performance (EPC)',
    ComplianceType.landlordInsurance => 'Landlord Insurance',
    ComplianceType.depositProtection => 'Deposit Protection',
    ComplianceType.propertyLicence => 'Property Licence',
    ComplianceType.otherDocuments => 'Other Documents',
  };

  String get screenTitle => switch (this) {
    ComplianceType.gasSafety => 'Gas Certificates',
    ComplianceType.electricalEicr => 'Electrical Certificates',
    ComplianceType.energyPerformance => 'Energy Performance',
    ComplianceType.landlordInsurance => 'Landlord Insurance',
    ComplianceType.depositProtection => 'Deposit Certificate',
    ComplianceType.propertyLicence => 'Property Licence',
    ComplianceType.otherDocuments => 'Other Documents',
  };

  IconData get icon => switch (this) {
    ComplianceType.gasSafety => Icons.water_drop_outlined,
    ComplianceType.electricalEicr => Icons.bolt_outlined,
    ComplianceType.energyPerformance => Icons.eco_outlined,
    ComplianceType.landlordInsurance => Icons.shield_outlined,
    ComplianceType.depositProtection => Icons.shield_outlined,
    ComplianceType.propertyLicence => Icons.verified_user_outlined,
    ComplianceType.otherDocuments => Icons.file_copy_outlined,
  };

  Color get iconColor => switch (this) {
    ComplianceType.gasSafety => const Color(0xFF0288D1),
    ComplianceType.electricalEicr => const Color(0xFFF57C00),
    ComplianceType.energyPerformance => const Color(0xFF2E7D32),
    ComplianceType.landlordInsurance => const Color(0xFF6A1B9A),
    ComplianceType.depositProtection => const Color(0xFF1565C0),
    ComplianceType.propertyLicence => const Color(0xFF37474F),
    ComplianceType.otherDocuments => const Color(0xFF1976D2),
  };
}

class ApplianceCheckModel {
  final String name;
  final String detail;
  final bool passed;
  const ApplianceCheckModel({required this.name, required this.detail, required this.passed});
}

class CertificateFileModel {
  final String id;
  final String fileName;
  final String sizeLabel;
  final String dateLabel;
  final bool isCurrent;

  // Extended fields — only populated for Gas Safety certificates.
  final String? refCertNo;
  final String? propertyAddress;
  final String? landlordOwner;
  final String? inspectionDate;
  final String? nextDueDate;
  final String? engineerName;
  final String? engineerNotes;
  final List<ApplianceCheckModel>? applianceChecks;
  final String? overallOutcome;

  const CertificateFileModel({
    required this.id,
    required this.fileName,
    required this.sizeLabel,
    required this.dateLabel,
    this.isCurrent = false,
    this.refCertNo,
    this.propertyAddress,
    this.landlordOwner,
    this.inspectionDate,
    this.nextDueDate,
    this.engineerName,
    this.engineerNotes,
    this.applianceChecks,
    this.overallOutcome,
  });

  bool get isGasExtended => applianceChecks != null;
}

class OtherDocumentModel {
  final String id;
  final String fileName;
  final String dateLabel;
  final String categoryLabel;
  final bool isShared;

  const OtherDocumentModel({required this.id, required this.fileName, required this.dateLabel, required this.categoryLabel, this.isShared = false});
}