// lib/models/property_model.dart — pura file replace koro
class TenantModel {
  final String id;
  final String name;
  final String? avatarUrl;

  const TenantModel({required this.id, required this.name, this.avatarUrl});
}

class UnitModel {
  final String id;
  final String label;
  final List<TenantModel> tenants;

  const UnitModel({required this.id, required this.label, this.tenants = const []});
}

enum PropertyType { detached, semiDetached, terraced, flatApartment, bungalow, maisonette, studio, other }

extension PropertyTypeX on PropertyType {
  String get label => switch (this) {
    PropertyType.detached => 'Detached',
    PropertyType.semiDetached => 'Semi-detached',
    PropertyType.terraced => 'Terraced',
    PropertyType.flatApartment => 'Flat / Apartment',
    PropertyType.bungalow => 'Bungalow',
    PropertyType.maisonette => 'Maisonette',
    PropertyType.studio => 'Studio',
    PropertyType.other => 'Other',
  };
}

enum EpcRating { a, b, c, d, e, f, g, notRated }

extension EpcRatingX on EpcRating {
  String get label => this == EpcRating.notRated ? 'Not rated' : name.toUpperCase();
}

enum CouncilTaxBand { a, b, c, d, e, f, g, h }

extension CouncilTaxBandX on CouncilTaxBand {
  String get label => 'Band ${name.toUpperCase()}';
}

class PropertyModel {
  final String id;
  final String name;
  final List<UnitModel> units;

  // ── Full property-detail fields (Properties feature) — all optional so
  // existing lightweight usages (Announcement/Maintenance/Finance) stay unaffected.
  final String? address;
  final String? postcode;
  final PropertyType? propertyType;
  final bool isHmo;
  final String? yearBuilt;
  final DateTime? datePurchased;
  final double? valuation;
  final DateTime? valuationDate;
  final String? totalSizeSqft;
  final String? alarmCode;
  final String? furnishedNote;
  final EpcRating? epcRating;
  final DateTime? epcExpiry;
  final DateTime? insuranceRenewal;
  final DateTime? mortgageRenewal;
  final CouncilTaxBand? councilTaxBand;
  final String? notes;
  final List<String> photoUrls;
  final double? monthlyRent;
  final int? unitsCountOverride;
  final int? occupiedUnitsCountOverride;

  const PropertyModel({
    required this.id,
    required this.name,
    this.units = const [],
    this.address,
    this.postcode,
    this.propertyType,
    this.isHmo = false,
    this.yearBuilt,
    this.datePurchased,
    this.valuation,
    this.valuationDate,
    this.totalSizeSqft,
    this.alarmCode,
    this.furnishedNote,
    this.epcRating,
    this.epcExpiry,
    this.insuranceRenewal,
    this.mortgageRenewal,
    this.councilTaxBand,
    this.notes,
    this.photoUrls = const [],
    this.monthlyRent,
    this.unitsCountOverride,
    this.occupiedUnitsCountOverride,
  });

  int get totalUnitsCount => unitsCountOverride ?? units.length;
  int get occupiedUnitsCount => occupiedUnitsCountOverride ?? units.where((u) => u.isOccupied).length;
  int get occupancyPercentage => totalUnitsCount == 0 ? 0 : ((occupiedUnitsCount / totalUnitsCount) * 100).round();
  bool get isFullyVacant => occupiedUnitsCount == 0;

  PropertyModel copyWith({
    String? name,
    List<UnitModel>? units,
    String? address,
    String? postcode,
    PropertyType? propertyType,
    bool? isHmo,
    String? yearBuilt,
    DateTime? datePurchased,
    double? valuation,
    DateTime? valuationDate,
    String? totalSizeSqft,
    String? alarmCode,
    String? furnishedNote,
    EpcRating? epcRating,
    DateTime? epcExpiry,
    DateTime? insuranceRenewal,
    DateTime? mortgageRenewal,
    CouncilTaxBand? councilTaxBand,
    String? notes,
    List<String>? photoUrls,
    double? monthlyRent,
    int? unitsCountOverride,
    int? occupiedUnitsCountOverride,
  }) {
    return PropertyModel(
      id: id,
      name: name ?? this.name,
      units: units ?? this.units,
      address: address ?? this.address,
      postcode: postcode ?? this.postcode,
      propertyType: propertyType ?? this.propertyType,
      isHmo: isHmo ?? this.isHmo,
      yearBuilt: yearBuilt ?? this.yearBuilt,
      datePurchased: datePurchased ?? this.datePurchased,
      valuation: valuation ?? this.valuation,
      valuationDate: valuationDate ?? this.valuationDate,
      totalSizeSqft: totalSizeSqft ?? this.totalSizeSqft,
      alarmCode: alarmCode ?? this.alarmCode,
      furnishedNote: furnishedNote ?? this.furnishedNote,
      epcRating: epcRating ?? this.epcRating,
      epcExpiry: epcExpiry ?? this.epcExpiry,
      insuranceRenewal: insuranceRenewal ?? this.insuranceRenewal,
      mortgageRenewal: mortgageRenewal ?? this.mortgageRenewal,
      councilTaxBand: councilTaxBand ?? this.councilTaxBand,
      notes: notes ?? this.notes,
      photoUrls: photoUrls ?? this.photoUrls,
      monthlyRent: monthlyRent ?? this.monthlyRent,
      unitsCountOverride: unitsCountOverride ?? this.unitsCountOverride,
      occupiedUnitsCountOverride: occupiedUnitsCountOverride ?? this.occupiedUnitsCountOverride,
    );
  }
}

extension UnitOccupancyX on UnitModel {
  bool get isOccupied => tenants.isNotEmpty;

  String get occupancyLabel =>
      isOccupied ? '${tenants.length} active tenant${tenants.length > 1 ? 's' : ''}' : 'Vacant — no tenants notified';

  String? get primaryTenantAvatar => tenants.isNotEmpty ? tenants.first.avatarUrl : null;
}