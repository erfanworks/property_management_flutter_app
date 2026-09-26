// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/controller/unit_detail_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import '../../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../model/property_detail_model.dart';
import '../model/unit_profile_model.dart';

class UnitDetailController extends GetxController {
  final Rx<UnitProfileModel?> unit = Rx<UnitProfileModel?>(null);
  final RxInt selectedTabIndex = 0.obs;

  // Add Unit form
  final unitNameController = TextEditingController();
  final rentController = TextEditingController();
  final bedsController = TextEditingController();
  final bathsController = TextEditingController();
  final sqftController = TextEditingController();
  final Rx<String?> formFloor = Rx<String?>(null);
  final floorNoteController = TextEditingController();
  final Rx<UnitTypeOption> formUnitType = UnitTypeOption.sameAsBuilding.obs;
  final Rx<FurnishedOption> formFurnished = FurnishedOption.notSet.obs;
  final RxList<String> formPhotoPaths = <String>[].obs;
  final RxInt formCoverIndex = 0.obs;
  final canSubmitUnitRx = false.obs;
  final isSubmittingUnit = false.obs;

  // Keys & Access
  final RxList<UnitKeySetModel> keySetsRx = <UnitKeySetModel>[].obs;
  final keyTypeController = TextEditingController();
  final keyQuantityController = TextEditingController();
  final keyLocationController = TextEditingController();
  final keyHeldByController = TextEditingController();
  final Rx<UnitKeySetModel?> editingKeySet = Rx<UnitKeySetModel?>(null);

  int get totalKeySets => keySetsRx.length;
  int get totalKeyQuantity => keySetsRx.fold(0, (s, k) => s + k.quantity);
  int get issuedQuantity => keySetsRx.where((k) => !k.isInSafe).fold(0, (s, k) => s + k.quantity);
  int get inSafeQuantity => keySetsRx.where((k) => k.isInSafe).fold(0, (s, k) => s + k.quantity);

  @override
  void onInit() {
    super.onInit();
    unitNameController.addListener(_validateUnitForm);
    rentController.addListener(_validateUnitForm);
  }

  void _validateUnitForm() {
    canSubmitUnitRx.value = unitNameController.text.trim().isNotEmpty && rentController.text.trim().isNotEmpty;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void loadUnit({required String propertyName, required UnitDetailModel unitSummary}) {
    unit.value = UnitProfileModel(
      id: unitSummary.id,
      name: unitSummary.label,
      propertyName: propertyName,
      floorLabel: unitSummary.floorLabel,
      isOccupied: unitSummary.isOccupied,
      beds: 1, baths: 1, sqft: 620,
      furnished: FurnishedOption.furnished,
      unitType: UnitTypeOption.sameAsBuilding,
      monthlyRent: unitSummary.rent,
      depositHeld: unitSummary.rent > 0 ? unitSummary.rent * 1.15 : 0,
      depositScheme: 'TDS',
      leaseStartLabel: '1 Sept 2023',
      leaseEndLabel: '31 Aug 2026',
      agreementType: 'Fixed-term AST',
      paymentScheduleLabel: 'Due 1st of month',
      members: const [
        UnitMemberModel(id: 'm1', name: 'Priya Sharma', roleLabel: 'Lead Member', keySetsSummary: '3 key sets'),
        UnitMemberModel(id: 'm2', name: 'James Chen', roleLabel: 'Member'),
        UnitMemberModel(id: 'm3', name: 'Aisha Khan', roleLabel: 'Member'),
      ],
      contractedRent: unitSummary.rent > 0 ? unitSummary.rent : 2200,
      collectedYtd: 0,
      nextDueAmount: 0,
      paymentLedger: const [
        PaymentLedgerEntryModel(monthLabel: 'May 2026', dateLabel: 'May 2, 2026', typeLabel: 'Rent', amount: 2200, statusLabel: 'Rent'),
        PaymentLedgerEntryModel(monthLabel: 'Jun 2026', dateLabel: 'Jun 2, 2026', typeLabel: 'Rent', amount: 2200, statusLabel: 'Rent'),
        PaymentLedgerEntryModel(monthLabel: 'Jul 2026', dateLabel: 'Due Jul 1, 2026', typeLabel: 'Rent', amount: 2200, statusLabel: 'Rent', isPaid: false),
      ],
      keySets: [
        UnitKeySetModel(id: 'k1', keyType: 'Front entrance key', quantity: 1, locationTag: 'Flat entrance', heldBy: 'Priya Sharma'),
        UnitKeySetModel(id: 'k2', keyType: 'Building electronic fob', quantity: 1, locationTag: 'Lobby', heldBy: 'Priya Sharma'),
      ],
    );
    keySetsRx.value = List.of(unit.value!.keySets);
    selectedTabIndex.value = 0;
  }

  void selectTab(int index) => selectedTabIndex.value = index;
  void openKeysAccess() => Get.toNamed(AppRoutes.keysAccessScreen);

  void startAddKeySet() {
    editingKeySet.value = null;
    keyTypeController.clear();
    keyQuantityController.text = '1';
    keyLocationController.clear();
    keyHeldByController.clear();
    Get.toNamed(AppRoutes.addKeySetScreen);
  }

  void startEditKeySet(UnitKeySetModel k) {
    editingKeySet.value = k;
    keyTypeController.text = k.keyType;
    keyQuantityController.text = '${k.quantity}';
    keyLocationController.text = k.locationTag;
    keyHeldByController.text = k.heldBy;
    Get.toNamed(AppRoutes.editKeySetScreen);
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void saveKeySet() {
    if (keyTypeController.text.trim().isEmpty) return;
    if (editingKeySet.value != null) {
      final k = editingKeySet.value!;
      k.keyType = keyTypeController.text.trim();
      k.quantity = int.tryParse(keyQuantityController.text.trim()) ?? k.quantity;
      k.locationTag = keyLocationController.text.trim();
      k.heldBy = keyHeldByController.text.trim();
      keySetsRx.refresh();
    } else {
      keySetsRx.add(UnitKeySetModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        keyType: keyTypeController.text.trim(),
        quantity: int.tryParse(keyQuantityController.text.trim()) ?? 1,
        locationTag: keyLocationController.text.trim(),
        heldBy: keyHeldByController.text.trim(),
      ));
    }
    AppSnackBar.success('Key set saved');
    Get.back();
  }

  void deleteKeySet(String id) {
    keySetsRx.removeWhere((k) => k.id == id);
    Get.back();
    AppSnackBar.success('Key set deleted');
  }

  Future<void> addUnitPhoto({required bool forForm}) async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
        if (file != null) _appendPhoto(file.path, forForm: forForm);
      },
      onGallery: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
        if (file != null) _appendPhoto(file.path, forForm: forForm);
      },
    );
  }

  void _appendPhoto(String path, {required bool forForm}) {
    if (forForm) {
      formPhotoPaths.add(path);
    } else {
      final u = unit.value;
      if (u == null) return;
      unit.value = u.copyWith(photoUrls: [...u.photoUrls, path]);
    }
  }

  void setCoverPhoto(int index, {required bool forForm}) {
    if (forForm) {
      formCoverIndex.value = index;
    } else {
      final u = unit.value;
      if (u == null) return;
      unit.value = u.copyWith(coverPhotoIndex: index);
    }
  }

  void resetAddUnitForm() {
    unitNameController.clear();
    rentController.clear();
    bedsController.clear();
    bathsController.clear();
    sqftController.clear();
    formFloor.value = null;
    floorNoteController.clear();
    formUnitType.value = UnitTypeOption.sameAsBuilding;
    formFurnished.value = FurnishedOption.notSet;
    formPhotoPaths.clear();
    formCoverIndex.value = 0;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> submitAddUnit() async {
    if (!canSubmitUnitRx.value) return;
    isSubmittingUnit.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSubmittingUnit.value = false;
    AppSnackBar.success('Unit added successfully');
    Get.back();
  }

  @override
  void onClose() {
    unitNameController.dispose();
    rentController.dispose();
    bedsController.dispose();
    bathsController.dispose();
    sqftController.dispose();
    floorNoteController.dispose();
    keyTypeController.dispose();
    keyQuantityController.dispose();
    keyLocationController.dispose();
    keyHeldByController.dispose();
    super.onClose();
  }
}