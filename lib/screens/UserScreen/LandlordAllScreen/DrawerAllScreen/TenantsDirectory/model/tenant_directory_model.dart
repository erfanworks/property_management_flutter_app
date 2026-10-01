// lib/screens/UserScreen/LandlordAllScreen/TenantsDirectory/model/tenant_directory_model.dart
class TenantDirectoryModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final String unitLabel;
  final String propertyName;
  final double rent;

  const TenantDirectoryModel({required this.id, required this.name, this.avatarUrl, required this.unitLabel, required this.propertyName, required this.rent});
}