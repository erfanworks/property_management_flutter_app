// lib/screens/UserScreen/LandlordAllScreen/Maintenance/model/contractor_model.dart — full replace
import 'package:flutter/material.dart';

class ReviewModel {
  final String reviewerName;
  final double rating;
  final String comment;
  final String jobLabel;
  final String dateLabel;
  const ReviewModel({required this.reviewerName, required this.rating, required this.comment, required this.jobLabel, required this.dateLabel});
}

class ContractorModel {
  final String id;
  final String name;
  final String roleLabel;
  final Color roleColor;
  final String? avatarUrl;
  final String? phone;
  final String? email;
  final bool isSuggested;
  final bool isVerified;
  final double? rating;
  final bool isOnline;
  final List<ReviewModel> reviews;

  const ContractorModel({
    required this.id,
    required this.name,
    required this.roleLabel,
    required this.roleColor,
    this.avatarUrl,
    this.phone,
    this.email,
    this.isSuggested = false,
    this.isVerified = false,
    this.rating,
    this.isOnline = false,
    this.reviews = const [],
  });
}