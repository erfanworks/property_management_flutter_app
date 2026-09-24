// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/model/property_detail_model.dart
class UnitDetailModel {
  final String id;
  final String label;
  final String floorLabel;
  final String bedBathLabel;
  final double rent;
  final bool isOccupied;
  final String? photoUrl;
  final String? tenantId;

  const UnitDetailModel({
    required this.id,
    required this.label,
    required this.floorLabel,
    required this.bedBathLabel,
    required this.rent,
    required this.isOccupied,
    this.photoUrl,
    this.tenantId,
  });
}

class FloorGroupModel {
  final String floorLabel;
  final List<UnitDetailModel> units;
  const FloorGroupModel({required this.floorLabel, required this.units});
}

class PropertyTenantModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final String unitLabel;
  final double rent;
  final bool isActive;

  const PropertyTenantModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.unitLabel,
    required this.rent,
    this.isActive = true,
  });
}

class TenantDetailModel {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final bool isActive;
  final String unitLabel;
  final String propertyName;
  final String dateOfBirth;
  final String nid;
  final String email;
  final String phone;
  final String emergencyContact;
  final String address;
  final String nidProofFileName;
  final String depositSummary;
  final String keysSummary;
  final String buildingInfoSummary;
  final int documentsCount;
  final String? latestNoteSummary;
  final String? latestNoteDateLabel;

  const TenantDetailModel({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.isActive = true,
    required this.unitLabel,
    required this.propertyName,
    required this.dateOfBirth,
    required this.nid,
    required this.email,
    required this.phone,
    required this.emergencyContact,
    required this.address,
    required this.nidProofFileName,
    required this.depositSummary,
    required this.keysSummary,
    required this.buildingInfoSummary,
    required this.documentsCount,
    this.latestNoteSummary,
    this.latestNoteDateLabel,
  });
}