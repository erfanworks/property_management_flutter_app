// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/model/asset_record_model.dart
import 'package:flutter/material.dart';

enum AssetRecordType { safetyAlarm, appliance }

extension AssetRecordTypeX on AssetRecordType {
  bool get isAppliance => this == AssetRecordType.appliance;
  String get screenTitle => isAppliance ? 'Appliances' : 'Safety & Alarms';
  String get nameLabel => isAppliance ? 'Appliance Name' : 'Alarm Name';
  String get nameHint => isAppliance ? 'e.g. Microwave,' : 'e.g. Smoke Alarm,';
  String get addTitle => isAppliance ? 'Add New Appliance' : 'Add Safety Alarm';
  String get saveLabel => isAppliance ? 'Save Appliance' : 'Save Alarm';
  String get detailSubtitle => isAppliance ? 'Appliance Details & Record' : 'Safety Alarm Details';
  String get editButtonLabel => isAppliance ? 'Edit This Appliance' : 'Edit This Alarm';
  String get deleteButtonLabel => isAppliance ? 'Delete This Appliance' : 'Delete This Alarm';
  IconData get icon => isAppliance ? Icons.build_circle_outlined : Icons.notifications_active_outlined;
}

class FlatFilterModel {
  final String id;
  final String label;
  const FlatFilterModel({required this.id, required this.label});
}

class AssetRecordModel {
  final String id;
  final String flatGroupId;
  final String flatGroupLabel;
  String? photoPath;
  String name;
  String secondaryLabel; // location (alarm) or brand/model (appliance)
  String expiryOrWarrantyLabel;
  DateTime? expiryDate;
  String modelType; // appliance only
  String warranty; // appliance only
  bool isRecorded;

  AssetRecordModel({
    required this.id,
    required this.flatGroupId,
    required this.flatGroupLabel,
    this.photoPath,
    required this.name,
    required this.secondaryLabel,
    required this.expiryOrWarrantyLabel,
    this.expiryDate,
    this.modelType = '',
    this.warranty = '',
    this.isRecorded = true,
  });
}