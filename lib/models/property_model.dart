// lib/models/property_model.dart
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

class PropertyModel {
  final String id;
  final String name;
  final List<UnitModel> units;

  const PropertyModel({required this.id, required this.name, this.units = const []});
}

extension UnitOccupancyX on UnitModel {
  bool get isOccupied => tenants.isNotEmpty;

  String get occupancyLabel => isOccupied
      ? '${tenants.length} active tenant${tenants.length > 1 ? 's' : ''}'
      : 'Vacant — no tenants notified';

  String? get primaryTenantAvatar => tenants.isNotEmpty ? tenants.first.avatarUrl : null;
}
