// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/model/inventory_model.dart
class InventoryItemModel {
  final String id;
  String name;
  String? photoPath;

  InventoryItemModel({required this.id, required this.name, this.photoPath});
}

class RoomModel {
  final String id;
  String name;
  String sizeLabel; // e.g. "95 sq ft" — empty if not set
  List<InventoryItemModel> items;

  RoomModel({required this.id, required this.name, this.sizeLabel = '', required this.items});
}