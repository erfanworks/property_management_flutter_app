// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/model/unit_profile_model.dart
import 'package:flutter/material.dart';

enum UnitTypeOption { sameAsBuilding, studio, oneBed, twoBed, threeBed, other }

extension UnitTypeOptionX on UnitTypeOption {
  String get label => switch (this) {
    UnitTypeOption.sameAsBuilding => 'Same as building',
    UnitTypeOption.studio => 'Studio',
    UnitTypeOption.oneBed => '1 Bedroom',
    UnitTypeOption.twoBed => '2 Bedroom',
    UnitTypeOption.threeBed => '3 Bedroom',
    UnitTypeOption.other => 'Other',
  };
}

enum FurnishedOption { notSet, furnished, unfurnished, partFurnished }

extension FurnishedOptionX on FurnishedOption {
  String get label => switch (this) {
    FurnishedOption.notSet => 'Not set',
    FurnishedOption.furnished => 'Furnished',
    FurnishedOption.unfurnished => 'Unfurnished',
    FurnishedOption.partFurnished => 'Part furnished',
  };
}

class UnitMemberModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final String roleLabel;
  final String? keySetsSummary;
  const UnitMemberModel({required this.id, required this.name, this.avatarUrl, required this.roleLabel, this.keySetsSummary});
}

class PaymentLedgerEntryModel {
  final String monthLabel;
  final String dateLabel;
  final String typeLabel;
  final double amount;
  final String statusLabel;
  final bool isPaid;
  const PaymentLedgerEntryModel({required this.monthLabel, required this.dateLabel, required this.typeLabel, required this.amount, required this.statusLabel, this.isPaid = true});
}

class UnitKeySetModel {
  final String id;
  String keyType;
  int quantity;
  String locationTag;
  String heldBy;
  UnitKeySetModel({required this.id, required this.keyType, required this.quantity, required this.locationTag, required this.heldBy});

  bool get isInSafe => heldBy.toLowerCase().contains('safe') || heldBy.toLowerCase().contains('office');
  String get custodyLabel => isInSafe ? 'In Safe' : 'Issued';
}

class UnitProfileModel {
  final String id;
  final String name;
  final String propertyName;
  final String floorLabel;
  final bool isOccupied;
  final List<String> photoUrls;
  final int coverPhotoIndex;
  final int beds;
  final int baths;
  final int sqft;
  final FurnishedOption furnished;
  final UnitTypeOption unitType;
  final String? floorNote;
  final double monthlyRent;
  final double depositHeld;
  final String depositScheme;
  final String leaseStartLabel;
  final String leaseEndLabel;
  final String agreementType;
  final String paymentScheduleLabel;
  final List<UnitMemberModel> members;
  final double contractedRent;
  final double collectedYtd;
  final double nextDueAmount;
  final List<PaymentLedgerEntryModel> paymentLedger;
  final List<UnitKeySetModel> keySets;

  const UnitProfileModel({
    required this.id, required this.name, required this.propertyName, required this.floorLabel,
    required this.isOccupied, this.photoUrls = const [], this.coverPhotoIndex = 0,
    required this.beds, required this.baths, required this.sqft, required this.furnished, required this.unitType,
    this.floorNote, required this.monthlyRent, required this.depositHeld, required this.depositScheme,
    required this.leaseStartLabel, required this.leaseEndLabel, required this.agreementType, required this.paymentScheduleLabel,
    required this.members, required this.contractedRent, required this.collectedYtd, required this.nextDueAmount,
    required this.paymentLedger, required this.keySets,
  });

  UnitProfileModel copyWith({List<String>? photoUrls, int? coverPhotoIndex, List<UnitKeySetModel>? keySets}) {
    return UnitProfileModel(
      id: id, name: name, propertyName: propertyName, floorLabel: floorLabel, isOccupied: isOccupied,
      photoUrls: photoUrls ?? this.photoUrls, coverPhotoIndex: coverPhotoIndex ?? this.coverPhotoIndex,
      beds: beds, baths: baths, sqft: sqft, furnished: furnished, unitType: unitType, floorNote: floorNote,
      monthlyRent: monthlyRent, depositHeld: depositHeld, depositScheme: depositScheme,
      leaseStartLabel: leaseStartLabel, leaseEndLabel: leaseEndLabel, agreementType: agreementType, paymentScheduleLabel: paymentScheduleLabel,
      members: members, contractedRent: contractedRent, collectedYtd: collectedYtd, nextDueAmount: nextDueAmount,
      paymentLedger: paymentLedger, keySets: keySets ?? this.keySets,
    );
  }
}