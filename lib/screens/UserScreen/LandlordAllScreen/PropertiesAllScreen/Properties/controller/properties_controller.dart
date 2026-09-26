// lib/screens/UserScreen/LandlordAllScreen/Properties/controller/properties_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../models/property_model.dart';
import '../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../widget/ConfirmActionDialog/confirm_action_dialog.dart';
import '../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import '../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../model/properties_filter.dart';

class PropertiesController extends GetxController {
  // ── List ──
  final RxList<PropertyModel> properties = <PropertyModel>[].obs;
  final Rx<PropertiesFilter> selectedFilter = PropertiesFilter.all.obs;

  // ── Form (shared by Add & Edit) ──
  final Rx<PropertyModel?> editingProperty = Rx<PropertyModel?>(null);
  bool get isEditing => editingProperty.value != null;

  final RxList<String> formPhotoPaths = <String>[].obs;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final postcodeController = TextEditingController();
  final floorsController = TextEditingController();
  final Rx<PropertyType?> formPropertyType = Rx<PropertyType?>(null);
  final isHmo = false.obs;
  final yearBuiltController = TextEditingController();
  final Rx<DateTime?> formDatePurchased = Rx<DateTime?>(null);
  final valuationController = TextEditingController();
  final Rx<DateTime?> formValuationDate = Rx<DateTime?>(null);
  final totalSizeController = TextEditingController();
  final alarmCodeController = TextEditingController();
  final Rx<EpcRating?> formEpcRating = Rx<EpcRating?>(null);
  final Rx<DateTime?> formEpcExpiry = Rx<DateTime?>(null);
  final Rx<DateTime?> formInsuranceRenewal = Rx<DateTime?>(null);
  final Rx<DateTime?> formMortgageRenewal = Rx<DateTime?>(null);
  final Rx<CouncilTaxBand?> formCouncilTaxBand = Rx<CouncilTaxBand?>(null);
  final notesController = TextEditingController();
  final canSubmitRx = false.obs;
  final isSubmitting = false.obs;

  int get totalPropertiesCount => properties.length;
  int get totalUnitsCount => properties.fold(0, (sum, p) => sum + p.totalUnitsCount);
  int get totalOccupiedUnitsCount => properties.fold(0, (sum, p) => sum + p.occupiedUnitsCount);
  int get overallOccupancyPercentage => totalUnitsCount == 0 ? 0 : ((totalOccupiedUnitsCount / totalUnitsCount) * 100).round();

  int get occupiedPropertiesCount => properties.where((p) => !p.isFullyVacant).length;
  int get vacantPropertiesCount => properties.where((p) => p.isFullyVacant).length;

  List<PropertyModel> get filteredProperties {
    switch (selectedFilter.value) {
      case PropertiesFilter.occupied:
        return properties.where((p) => !p.isFullyVacant).toList();
      case PropertiesFilter.vacant:
        return properties.where((p) => p.isFullyVacant).toList();
      case PropertiesFilter.all:
        return properties;
    }
  }

  static String formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  void onInit() {
    super.onInit();
    fetchProperties();
    nameController.addListener(_validate);
    addressController.addListener(_validate);
  }

  void _validate() {
    canSubmitRx.value = nameController.text.trim().isNotEmpty && addressController.text.trim().isNotEmpty;
  }

  void selectFilter(PropertiesFilter filter) => selectedFilter.value = filter;

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchProperties() async {
    properties.value = [
      PropertyModel(
        id: 'p1', name: '12 Park Lane', address: 'London, SW1A 1AA',
        monthlyRent: 11750, unitsCountOverride: 5, occupiedUnitsCountOverride: 2,
      ),
      PropertyModel(
        id: 'p2', name: '45 Queens Road', address: 'London, SW2 3TR',
        monthlyRent: 7400, unitsCountOverride: 4, occupiedUnitsCountOverride: 1,
      ),
      PropertyModel(
        id: 'p3', name: '88 King Street', address: 'London, EC2V 8BB',
        monthlyRent: 2100, unitsCountOverride: 1, occupiedUnitsCountOverride: 0,
      ),
      PropertyModel(
        id: 'p4', name: '15 Victoria Ave', address: 'London, N1 4QP',
        monthlyRent: 0, unitsCountOverride: 4, occupiedUnitsCountOverride: 4,
      ),
    ];
  }

  void openAddProperty() {
    editingProperty.value = null;
    _resetForm();
    Get.toNamed(AppRoutes.propertyFormScreen);
  }

  void openEditProperty(PropertyModel property) {
    editingProperty.value = property;
    formPhotoPaths.value = List.of(property.photoUrls);
    nameController.text = property.name;
    addressController.text = property.address ?? '';
    postcodeController.text = property.postcode ?? '';
    formPropertyType.value = property.propertyType;
    isHmo.value = property.isHmo;
    yearBuiltController.text = property.yearBuilt ?? '';
    formDatePurchased.value = property.datePurchased;
    valuationController.text = property.valuation != null ? property.valuation!.toStringAsFixed(0) : '';
    formValuationDate.value = property.valuationDate;
    totalSizeController.text = property.totalSizeSqft ?? '';
    alarmCodeController.text = property.alarmCode ?? '';
    formEpcRating.value = property.epcRating;
    formEpcExpiry.value = property.epcExpiry;
    formInsuranceRenewal.value = property.insuranceRenewal;
    formMortgageRenewal.value = property.mortgageRenewal;
    formCouncilTaxBand.value = property.councilTaxBand;
    notesController.text = property.notes ?? '';
    _validate();
    Get.toNamed(AppRoutes.propertyFormScreen);
  }

  void _resetForm() {
    formPhotoPaths.clear();
    nameController.clear();
    addressController.clear();
    postcodeController.clear();
    floorsController.clear();
    formPropertyType.value = null;
    isHmo.value = false;
    yearBuiltController.clear();
    formDatePurchased.value = null;
    valuationController.clear();
    formValuationDate.value = null;
    totalSizeController.clear();
    alarmCodeController.clear();
    formEpcRating.value = null;
    formEpcExpiry.value = null;
    formInsuranceRenewal.value = null;
    formMortgageRenewal.value = null;
    formCouncilTaxBand.value = null;
    notesController.clear();
  }

  Future<void> pickPropertyPhoto() async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        // NOTE: uses image_picker directly, same as Announcement/Maintenance flows.
      },
      onGallery: () async {},
    );
  }

  void addPickedPhoto(String path) => formPhotoPaths.add(path);
  void removePhoto(int index) => formPhotoPaths.removeAt(index);

  Future<void> pickFormDate(BuildContext context, Rx<DateTime?> target) async {
    final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
    if (picked != null) target.value = picked;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> submitProperty() async {
    if (!canSubmitRx.value) return;
    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 1));

    final data = PropertyModel(
      id: editingProperty.value?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      units: editingProperty.value?.units ?? const [],
      address: addressController.text.trim(),
      postcode: postcodeController.text.trim().isEmpty ? null : postcodeController.text.trim(),
      propertyType: formPropertyType.value,
      isHmo: isHmo.value,
      yearBuilt: yearBuiltController.text.trim().isEmpty ? null : yearBuiltController.text.trim(),
      datePurchased: formDatePurchased.value,
      valuation: double.tryParse(valuationController.text.trim()),
      valuationDate: formValuationDate.value,
      totalSizeSqft: totalSizeController.text.trim().isEmpty ? null : totalSizeController.text.trim(),
      alarmCode: alarmCodeController.text.trim().isEmpty ? null : alarmCodeController.text.trim(),
      epcRating: formEpcRating.value,
      epcExpiry: formEpcExpiry.value,
      insuranceRenewal: formInsuranceRenewal.value,
      mortgageRenewal: formMortgageRenewal.value,
      councilTaxBand: formCouncilTaxBand.value,
      notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
      photoUrls: List.of(formPhotoPaths),
      monthlyRent: editingProperty.value?.monthlyRent,
      unitsCountOverride: editingProperty.value?.unitsCountOverride,
      occupiedUnitsCountOverride: editingProperty.value?.occupiedUnitsCountOverride,
    );

    if (isEditing) {
      final index = properties.indexWhere((p) => p.id == data.id);
      if (index != -1) properties[index] = data;
    } else {
      properties.insert(0, data);
    }

    isSubmitting.value = false;
    AppSnackBar.success(isEditing ? 'Property updated' : 'Property added');
    Get.back();
  }

  void confirmDeleteProperty(PropertyModel property) {
    ConfirmActionDialog.show(
      title: ConstString.removeProperty,
      message: 'Remove ${property.name}? This cannot be undone.',
      confirmLabel: ConstString.remove,
      onConfirm: () {
        // TODO: Replace with Dio API call once backend endpoint is ready.
        properties.removeWhere((p) => p.id == property.id);
        AppSnackBar.success('Property removed');
      },
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    postcodeController.dispose();
    yearBuiltController.dispose();
    valuationController.dispose();
    totalSizeController.dispose();
    alarmCodeController.dispose();
    notesController.dispose();
    super.onClose();
  }
}