// lib/screens/UserScreen/LandlordAllScreen/Announcement/model/property_model.dart
class FlatModel {
  final String id;
  final String name;
  final String? tenantAvatarUrl;
  final String statusLabel;

  const FlatModel({
    required this.id,
    required this.name,
    this.tenantAvatarUrl,
    required this.statusLabel,
  });
}

class PropertyModel {
  final String id;
  final String name;
  final List<FlatModel> flats;

  const PropertyModel({required this.id, required this.name, required this.flats});
}