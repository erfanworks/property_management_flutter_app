// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/controller/asset_records_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import '../../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../model/asset_record_model.dart';

class AssetRecordsController extends GetxController {
  AssetRecordsController(this.type);
  final AssetRecordType type;

  final RxList<FlatFilterModel> flatFilters = <FlatFilterModel>[].obs;
  final Rx<FlatFilterModel?> selectedFlatFilter = Rx<FlatFilterModel?>(null);
  final RxList<AssetRecordModel> records = <AssetRecordModel>[].obs;

  // form state (add/edit)
  final nameController = TextEditingController();
  final secondaryController = TextEditingController();
  final modelTypeController = TextEditingController();
  final warrantyController = TextEditingController();
  final Rx<DateTime?> formExpiryDate = Rx<DateTime?>(null);
  final Rx<String?> formPhotoPath = Rx<String?>(null);
  final Rx<AssetRecordModel?> editingRecord = Rx<AssetRecordModel?>(null);

  List<AssetRecordModel> get filteredRecords {
    final f = selectedFlatFilter.value;
    if (f == null || f.id == 'all') return records;
    return records.where((r) => r.flatGroupId == f.id).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchFlatFilters();
    fetchRecords();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchFlatFilters() async {
    flatFilters.value = const [
      FlatFilterModel(id: 'all', label: 'All'),
      FlatFilterModel(id: 'f1_2', label: 'Flat 1 · 2'),
      FlatFilterModel(id: 'f2a', label: 'Flat 2A'),
      FlatFilterModel(id: 'f2b', label: 'Flat 2B'),
      FlatFilterModel(id: 'f3', label: 'Flat 3'),
    ];
    selectedFlatFilter.value = flatFilters.first;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchRecords() async {
    if (type.isAppliance) {
      records.value = [
        AssetRecordModel(id: 'a1', flatGroupId: 'f1_2', flatGroupLabel: 'Flat 1', name: 'Boiler', secondaryLabel: 'Worcester Bosch Greenstar 30i', expiryOrWarrantyLabel: 'Exp: 15 Jan 2026', modelType: 'Combi Boiler 30kW', warranty: 'Until Mar 2027', photoPath: 'https://picsum.photos/id/1060/400/300'),
        AssetRecordModel(id: 'a2', flatGroupId: 'f1_2', flatGroupLabel: 'Flat 1', name: 'Oven & Hob', secondaryLabel: 'Bosch Serie 6', expiryOrWarrantyLabel: 'Exp: 15 Jan 2026', warranty: 'Until Mar 2027', photoPath: 'https://picsum.photos/id/1062/400/300'),
        AssetRecordModel(id: 'a3', flatGroupId: 'f1_2', flatGroupLabel: 'Flat 1', name: 'Fridge Freezer', secondaryLabel: 'Samsung SpaceMax', expiryOrWarrantyLabel: 'Exp: 15 Jan 2026', warranty: 'Until Mar 2027', photoPath: 'https://picsum.photos/id/1069/400/300'),
        AssetRecordModel(id: 'a4', flatGroupId: 'f1_2', flatGroupLabel: 'Flat 1', name: 'Dishwasher', secondaryLabel: 'Bosch Serie 4', expiryOrWarrantyLabel: 'Exp: 15 Jan 2026', warranty: 'Until Mar 2027', photoPath: 'https://picsum.photos/id/1070/400/300'),
        AssetRecordModel(id: 'a5', flatGroupId: 'f1_2', flatGroupLabel: 'Flat 1', name: 'Washing Machine', secondaryLabel: 'LG AI DirectDrive 9kg', expiryOrWarrantyLabel: 'Exp: 15 Jan 2026', warranty: 'Until Mar 2027', photoPath: 'https://picsum.photos/id/1071/400/300'),
      ];
    } else {
      records.value = [
        AssetRecordModel(id: 's1', flatGroupId: 'f1_2', flatGroupLabel: 'Flat 1 · 2', name: 'Smoke Alarm', secondaryLabel: 'Hallway / Landing', expiryOrWarrantyLabel: 'Exp: 15 Jan 2026', photoPath: 'https://picsum.photos/id/1060/400/300'),
        AssetRecordModel(id: 's2', flatGroupId: 'f1_2', flatGroupLabel: 'Flat 1 · 2', name: 'Heat Alarm', secondaryLabel: 'Kitchen Ceiling', expiryOrWarrantyLabel: 'Exp: 15 Jan 2026', photoPath: 'https://picsum.photos/id/1062/400/300'),
        AssetRecordModel(id: 's3', flatGroupId: 'f1_2', flatGroupLabel: 'Flat 1 · 2', name: 'CO Alarm', secondaryLabel: 'Boiler Room / Bedroom', expiryOrWarrantyLabel: 'Exp: 15 Jan 2026', photoPath: 'https://picsum.photos/id/1069/400/300'),
      ];
    }
  }

  void selectFlatFilter(FlatFilterModel? f) => selectedFlatFilter.value = f;

  void startAdd() {
    editingRecord.value = null;
    nameController.clear();
    secondaryController.clear();
    modelTypeController.clear();
    warrantyController.clear();
    formExpiryDate.value = null;
    formPhotoPath.value = null;
  }

  void startEdit(AssetRecordModel r) {
    editingRecord.value = r;
    nameController.text = r.name;
    secondaryController.text = r.secondaryLabel;
    modelTypeController.text = r.modelType;
    warrantyController.text = r.warranty;
    formExpiryDate.value = r.expiryDate;
    formPhotoPath.value = r.photoPath;
  }

  Future<void> pickFormPhoto() async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
        if (file != null) formPhotoPath.value = file.path;
      },
      onGallery: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
        if (file != null) formPhotoPath.value = file.path;
      },
    );
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void saveForm() {
    if (nameController.text.trim().isEmpty) return;
    if (editingRecord.value != null) {
      final r = editingRecord.value!;
      r.name = nameController.text.trim();
      r.secondaryLabel = secondaryController.text.trim();
      r.modelType = modelTypeController.text.trim();
      r.warranty = warrantyController.text.trim();
      r.expiryDate = formExpiryDate.value;
      r.photoPath = formPhotoPath.value;
      records.refresh();
    } else {
      records.insert(0, AssetRecordModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        flatGroupId: selectedFlatFilter.value?.id ?? 'f1_2',
        flatGroupLabel: selectedFlatFilter.value?.label ?? '-',
        name: nameController.text.trim(),
        secondaryLabel: secondaryController.text.trim(),
        expiryOrWarrantyLabel: formExpiryDate.value != null ? 'Exp: ${_fmt(formExpiryDate.value!)}' : '',
        expiryDate: formExpiryDate.value,
        modelType: modelTypeController.text.trim(),
        warranty: warrantyController.text.trim(),
        photoPath: formPhotoPath.value,
      ));
    }
    AppSnackBar.success('${type.isAppliance ? 'Appliance' : 'Alarm'} saved');
  }

  void deleteRecord(String id) {
    records.removeWhere((r) => r.id == id);
    AppSnackBar.success('${type.isAppliance ? 'Appliance' : 'Alarm'} deleted');
  }

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';
}