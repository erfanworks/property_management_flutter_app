// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/controller/inventory_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import '../../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../model/asset_record_model.dart';
import '../model/inventory_model.dart';

class InventoryController extends GetxController {
  final RxList<FlatFilterModel> flatFilters = <FlatFilterModel>[].obs;
  final Rx<FlatFilterModel?> selectedFlatFilter = Rx<FlatFilterModel?>(null);
  final RxList<RoomModel> rooms = <RoomModel>[].obs;
  final Rx<RoomModel?> selectedRoom = Rx<RoomModel?>(null);

  // Room form
  final roomNameController = TextEditingController();
  final roomSizeController = TextEditingController();
  final Rx<RoomModel?> editingRoom = Rx<RoomModel?>(null);

  // Item form
  final itemNameController = TextEditingController();
  final Rx<String?> itemPhotoPath = Rx<String?>(null);
  final Rx<InventoryItemModel?> editingItem = Rx<InventoryItemModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchFlatFilters();
    fetchRooms();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchFlatFilters() async {
    flatFilters.value = const [
      FlatFilterModel(id: 'f1', label: 'Flat 1 · Sarah Johnson'),
      FlatFilterModel(id: 'f2a', label: 'Flat 2A'),
      FlatFilterModel(id: 'f2b', label: 'Flat 2B'),
    ];
    selectedFlatFilter.value = flatFilters.first;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchRooms() async {
    rooms.value = [
      RoomModel(id: 'r1', name: 'Kitchen', sizeLabel: '95 sq ft', items: [
        InventoryItemModel(id: 'i1', name: 'Oven / hob'),
        InventoryItemModel(id: 'i2', name: 'Fridge freezer'),
        InventoryItemModel(id: 'i3', name: 'Microwave'),
        InventoryItemModel(id: 'i4', name: 'Extractor fan'),
        InventoryItemModel(id: 'i5', name: 'Worktops'),
      ]),
      RoomModel(id: 'r2', name: 'Living room', sizeLabel: '180 sq ft', items: List.generate(5, (i) => InventoryItemModel(id: 'lr$i', name: 'Item ${i + 1}'))),
      RoomModel(id: 'r3', name: 'Bedroom', sizeLabel: '135 sq ft', items: List.generate(5, (i) => InventoryItemModel(id: 'br$i', name: 'Item ${i + 1}'))),
      RoomModel(id: 'r4', name: 'Bathroom', sizeLabel: '50 sq ft', items: List.generate(5, (i) => InventoryItemModel(id: 'ba$i', name: 'Item ${i + 1}'))),
      RoomModel(id: 'r5', name: 'Hallway', sizeLabel: '45 sq ft', items: List.generate(5, (i) => InventoryItemModel(id: 'ha$i', name: 'Item ${i + 1}'))),
    ];
  }

  void selectFlatFilter(FlatFilterModel? f) => selectedFlatFilter.value = f;

  void openRoomItems(RoomModel room) {
    selectedRoom.value = room;
    Get.toNamed(AppRoutes.roomItemsScreen);
  }

  void startAddRoom() {
    editingRoom.value = null;
    roomNameController.clear();
    roomSizeController.clear();
  }

  void startEditRoom(RoomModel r) {
    editingRoom.value = r;
    roomNameController.text = r.name;
    roomSizeController.text = r.sizeLabel.replaceAll(' sq ft', '');
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void saveRoom() {
    if (roomNameController.text.trim().isEmpty) return;
    final sizeText = roomSizeController.text.trim();
    final sizeLabel = sizeText.isEmpty ? '' : '$sizeText sq ft';
    if (editingRoom.value != null) {
      final r = editingRoom.value!;
      r.name = roomNameController.text.trim();
      r.sizeLabel = sizeLabel;
      rooms.refresh();
    } else {
      rooms.add(RoomModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: roomNameController.text.trim(), sizeLabel: sizeLabel, items: []));
    }
    Get.back();
    AppSnackBar.success('Room saved');
  }

  void deleteRoom(String id) {
    rooms.removeWhere((r) => r.id == id);
    AppSnackBar.success('Room deleted');
  }

  Future<void> pickItemPhoto() async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
        if (file != null) itemPhotoPath.value = file.path;
      },
      onGallery: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
        if (file != null) itemPhotoPath.value = file.path;
      },
    );
  }

  void startAddItem() {
    editingItem.value = null;
    itemNameController.clear();
    itemPhotoPath.value = null;
  }

  void startEditItem(InventoryItemModel item) {
    editingItem.value = item;
    itemNameController.text = item.name;
    itemPhotoPath.value = item.photoPath;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void saveItem() {
    if (itemNameController.text.trim().isEmpty) return;
    final room = selectedRoom.value;
    if (room == null) return;
    if (editingItem.value != null) {
      final it = editingItem.value!;
      it.name = itemNameController.text.trim();
      it.photoPath = itemPhotoPath.value;
    } else {
      room.items.add(InventoryItemModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: itemNameController.text.trim(), photoPath: itemPhotoPath.value));
    }
    rooms.refresh();
    Get.back();
    AppSnackBar.success('Item saved');
  }

  void deleteItem(String id) {
    selectedRoom.value?.items.removeWhere((i) => i.id == id);
    rooms.refresh();
    AppSnackBar.success('Item deleted');
  }
}