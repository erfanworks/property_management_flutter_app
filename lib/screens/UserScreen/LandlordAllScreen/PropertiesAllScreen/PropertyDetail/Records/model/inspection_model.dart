// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/model/inspection_model.dart
import 'package:flutter/material.dart';

class InspectionRecordModel {
  final String id;
  final String areaLabel;
  final String typeLabel;
  final String dateLabel;
  final bool isCommunal;
  final String? addressLabel;
  final String? inspectorNotes;
  final List<String> photoUrls;

  const InspectionRecordModel({
    required this.id, required this.areaLabel, required this.typeLabel, required this.dateLabel,
    this.isCommunal = false, this.addressLabel, this.inspectorNotes, this.photoUrls = const [],
  });
}

enum RoomCheckStatus { none, pass, fair, defect }

class RoomChecklistItemModel {
  final String roomName;
  final IconData icon;
  RoomCheckStatus status;
  RoomChecklistItemModel({required this.roomName, required this.icon, this.status = RoomCheckStatus.none});
}