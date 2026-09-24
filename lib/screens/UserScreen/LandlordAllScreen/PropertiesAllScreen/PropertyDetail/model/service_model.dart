// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/model/service_model.dart
import 'package:flutter/material.dart';

enum ServiceType { gas, electricity, water, wifi, council, parking }

extension ServiceTypeX on ServiceType {
  String get label => switch (this) {
    ServiceType.gas => 'Gas',
    ServiceType.electricity => 'Electricity',
    ServiceType.water => 'Water',
    ServiceType.wifi => 'Wi-Fi',
    ServiceType.council => 'Council',
    ServiceType.parking => 'Parking',
  };

  IconData get icon => switch (this) {
    ServiceType.gas => Icons.local_fire_department_outlined,
    ServiceType.electricity => Icons.bolt_outlined,
    ServiceType.water => Icons.water_drop_outlined,
    ServiceType.wifi => Icons.wifi_rounded,
    ServiceType.council => Icons.account_balance_outlined,
    ServiceType.parking => Icons.local_parking_outlined,
  };

  String get editTitle => switch (this) {
    ServiceType.gas => 'Edit Gas info',
    ServiceType.electricity => 'Edit Electricity info',
    ServiceType.water => 'Edit Water info',
    ServiceType.wifi => 'Edit Wi-Fi info',
    ServiceType.council => 'Edit Council info',
    ServiceType.parking => 'Edit Parking info',
  };
}

class ServiceFieldModel {
  final String key;
  final String label;
  String value;
  final bool isMultiline;
  final List<String>? dropdownOptions;

  ServiceFieldModel({required this.key, required this.label, this.value = '', this.isMultiline = false, this.dropdownOptions});

  ServiceFieldModel copy() => ServiceFieldModel(key: key, label: label, value: value, isMultiline: isMultiline, dropdownOptions: dropdownOptions);
}

class ServiceModel {
  final ServiceType type;
  String? photoPath;
  final List<ServiceFieldModel> fields;
  String summaryLine;

  ServiceModel({required this.type, this.photoPath, required this.fields, this.summaryLine = ''});

  String? fieldValue(String key) {
    for (final f in fields) {
      if (f.key == key) return f.value;
    }
    return null;
  }
}