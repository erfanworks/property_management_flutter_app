// lib/screens/UserScreen/LandlordAllScreen/Maintenance/model/maintenance_issue_model.dart
import 'package:flutter/material.dart';
import '../../../../../constant/const_color.dart';
import 'contractor_model.dart';
import 'maintenance_property_model.dart';

enum IssueStatus { open, assigned, inProgress, done }
enum IssuePriority { low, medium, high, urgent }
enum IssueLocationType { unit, communal }

extension IssueStatusX on IssueStatus {
  String get label => switch (this) {
    IssueStatus.open => 'Open',
    IssueStatus.assigned => 'Assigned',
    IssueStatus.inProgress => 'In progress',
    IssueStatus.done => 'Done',
  };

  Color get color => switch (this) {
    IssueStatus.open => ConstColor.tenantIconColor,
    IssueStatus.assigned || IssueStatus.inProgress => ConstColor.primaryColor,
    IssueStatus.done => ConstColor.tenantIconColor,
  };

  Color get bg => switch (this) {
    IssueStatus.open => ConstColor.tenantIconBg,
    IssueStatus.assigned || IssueStatus.inProgress => ConstColor.infoBg,
    IssueStatus.done => ConstColor.tenantIconBg,
  };

  String get detailTagLabel => switch (this) {
    IssueStatus.open => 'Needs contractor',
    IssueStatus.assigned => 'Assigned',
    IssueStatus.inProgress => 'In progress',
    IssueStatus.done => 'Completed',
  };

  Color get detailTagColor => this == IssueStatus.open ? ConstColor.purpleColor : color;
  Color get detailTagBg => this == IssueStatus.open ? ConstColor.purpleBg : bg;

  int get stepIndex => switch (this) {
    IssueStatus.open => 0,
    IssueStatus.assigned => 1,
    IssueStatus.inProgress => 2,
    IssueStatus.done => 3,
  };
}

extension IssuePriorityX on IssuePriority {
  String get label => switch (this) {
    IssuePriority.low => 'Low',
    IssuePriority.medium => 'Medium',
    IssuePriority.high => 'High',
    IssuePriority.urgent => 'Urgent',
  };

  Color get color => switch (this) {
    IssuePriority.low => ConstColor.tenantIconColor,
    IssuePriority.medium => ConstColor.contractorIconColor,
    IssuePriority.high || IssuePriority.urgent => ConstColor.errorColor,
  };

  Color get bg => switch (this) {
    IssuePriority.low => ConstColor.tenantIconBg,
    IssuePriority.medium => ConstColor.contractorIconBg,
    IssuePriority.high || IssuePriority.urgent => ConstColor.errorBg,
  };
}

class MaintenanceIssueModel {
  final String id;
  final String refCode;
  final String title;
  final String description;
  final String propertyName;
  final String unitLabel;
  final String tenantName;
  final String tenantPhone;
  final IssueTypeModel issueType;
  final IssuePriority priority;
  final IssueStatus status;
  final List<String> photoUrls;
  final int videoCount;
  final String reportedAgoLabel;
  final bool tenantPays;
  final bool isTenantReported;
  final ContractorModel? assignedContractor;
  final String? visitLabel;

  const MaintenanceIssueModel({
    required this.id,
    required this.refCode,
    required this.title,
    required this.description,
    required this.propertyName,
    required this.unitLabel,
    required this.tenantName,
    required this.tenantPhone,
    required this.issueType,
    required this.priority,
    required this.status,
    required this.photoUrls,
    required this.videoCount,
    required this.reportedAgoLabel,
    required this.tenantPays,
    required this.isTenantReported,
    this.assignedContractor,
    this.visitLabel,
  });

  MaintenanceIssueModel copyWith({IssueStatus? status, ContractorModel? assignedContractor, String? visitLabel}) {
    return MaintenanceIssueModel(
      id: id,
      refCode: refCode,
      title: title,
      description: description,
      propertyName: propertyName,
      unitLabel: unitLabel,
      tenantName: tenantName,
      tenantPhone: tenantPhone,
      issueType: issueType,
      priority: priority,
      status: status ?? this.status,
      photoUrls: photoUrls,
      videoCount: videoCount,
      reportedAgoLabel: reportedAgoLabel,
      tenantPays: tenantPays,
      isTenantReported: isTenantReported,
      assignedContractor: assignedContractor ?? this.assignedContractor,
      visitLabel: visitLabel ?? this.visitLabel,
    );
  }
}