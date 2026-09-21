// lib/screens/UserScreen/LandlordAllScreen/Maintenance/model/maintenance_property_model.dart
import 'package:flutter/material.dart';

class MaintenanceUnitModel {
  final String id;
  final String label;
  const MaintenanceUnitModel({required this.id, required this.label});
}

class MaintenancePropertyModel {
  final String id;
  final String name;
  final List<MaintenanceUnitModel> units;
  const MaintenancePropertyModel({required this.id, required this.name, required this.units});
}

class IssueTypeModel {
  final String id;
  final String label;
  final Color color;
  final Color bg;
  const IssueTypeModel({required this.id, required this.label, required this.color, required this.bg});
}