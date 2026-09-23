// lib/screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/model/contractor_model.dart
import 'package:flutter/material.dart';

class ContractorModel {
  final String id;
  final String name;
  final String roleLabel;
  final Color roleColor;
  final String? avatarUrl;
  final String? phone;
  final bool isSuggested;

  const ContractorModel({
    required this.id,
    required this.name,
    required this.roleLabel,
    required this.roleColor,
    this.avatarUrl,
    this.phone,
    this.isSuggested = false,
  });
}