// lib/screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/controller/maintenance_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../widget/ConfirmActionDialog/confirm_action_dialog.dart';
import '../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import '../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../../../../models/property_model.dart';
import '../model/contractor_model.dart';
import '../model/maintenance_issue_model.dart';
import '../model/maintenance_property_model.dart';

class MaintenanceController extends GetxController {
  // ── List ──
  final RxList<MaintenanceIssueModel> issues = <MaintenanceIssueModel>[].obs;
  final RxString searchQuery = ''.obs;
  final Rx<PropertyModel?> filterProperty = Rx<PropertyModel?>(null);
  final Rx<UnitModel?> filterUnit = Rx<UnitModel?>(null);
  final RxInt selectedFilterTabIndex = 0.obs;

  // ── Detail ──
  final Rx<MaintenanceIssueModel?> selectedIssue = Rx<MaintenanceIssueModel?>(null);

  // ── Reference data ──
  final RxList<PropertyModel> properties = <PropertyModel>[].obs;
  final RxList<IssueTypeModel> issueTypes = <IssueTypeModel>[].obs;
  final RxList<ContractorModel> contractors = <ContractorModel>[].obs;
  static const List<String> communalAreas = ['Hallway', 'Stairwell', 'Roof', 'Garden', 'Boiler room', 'Other'];

  // ── Log Issue form ──
  final Rx<PropertyModel?> formProperty = Rx<PropertyModel?>(null);
  final Rx<IssueLocationType> formLocationType = IssueLocationType.unit.obs;
  final Rx<UnitModel?> formUnit = Rx<UnitModel?>(null);
  final Rx<String?> formCommunalArea = Rx<String?>(null);
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final Rx<IssueTypeModel?> formIssueType = Rx<IssueTypeModel?>(null);
  final Rx<IssuePriority> formPriority = IssuePriority.medium.obs;
  final Rx<String?> pickedMediaPath = Rx<String?>(null);
  final isSubmitting = false.obs;
  final canSubmitRx = false.obs;

  List<MaintenanceIssueModel> get filteredIssues {
    return issues.where((issue) {
      if (filterProperty.value != null && issue.propertyName != filterProperty.value!.name) return false;
      if (filterUnit.value != null && issue.unitLabel != filterUnit.value!.label) return false;
      if (selectedFilterTabIndex.value == 1 && !issue.isTenantReported) return false;
      if (selectedFilterTabIndex.value == 2 && issue.isTenantReported) return false;
      final q = searchQuery.value.trim().toLowerCase();
      if (q.isNotEmpty &&
          !issue.title.toLowerCase().contains(q) &&
          !issue.tenantName.toLowerCase().contains(q) &&
          !issue.unitLabel.toLowerCase().contains(q)) {
        return false;
      }
      return true;
    }).toList();
  }

  int get tenantReportsCount => issues.where((i) => i.isTenantReported).length;
  int get myLogsCount => issues.where((i) => !i.isTenantReported).length;

  @override
  void onInit() {
    super.onInit();
    fetchIssues();
    fetchProperties();
    fetchIssueTypes();
    fetchContractors();
    titleController.addListener(_validate);
    descriptionController.addListener(_validate);
    ever(formProperty, (_) => _validate());
    ever(formLocationType, (_) => _validate());
    ever(formUnit, (_) => _validate());
    ever(formCommunalArea, (_) => _validate());
    ever(formIssueType, (_) => _validate());
  }

  void _validate() {
    final locationValid = formLocationType.value == IssueLocationType.unit ? formUnit.value != null : formCommunalArea.value != null;
    canSubmitRx.value = formProperty.value != null &&
        locationValid &&
        titleController.text.trim().isNotEmpty &&
        formIssueType.value != null &&
        descriptionController.text.trim().isNotEmpty;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchProperties() async {
    properties.value = const [
      PropertyModel(id: 'p1', name: '12 Park Lane', units: [
        UnitModel(id: 'u1', label: 'Flat 1 · 1st Floor (occupied)'),
        UnitModel(id: 'u2', label: 'Flat 2A · 2nd Floor (occupied)'),
        UnitModel(id: 'u3', label: 'Flat 2B · 2nd Floor (occupied)'),
        UnitModel(id: 'u4', label: 'Flat 3 · 3rd Floor (occupied)'),
      ]),
      PropertyModel(id: 'p2', name: '45 Queens Road'),
      PropertyModel(id: 'p3', name: '88 King Street'),
      PropertyModel(id: 'p4', name: '15 Victoria Ave'),
    ];
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchIssueTypes() async {
    issueTypes.value = [
      IssueTypeModel(id: 't1', label: 'Plumber — Plumbing & Heating', color: ConstColor.primaryColor, bg: ConstColor.infoBg),
      IssueTypeModel(id: 't2', label: 'Heating engineer — Heating & Gas', color: ConstColor.contractorIconColor, bg: ConstColor.contractorIconBg),
      IssueTypeModel(id: 't3', label: 'Electrician — Electrical', color: ConstColor.purpleColor, bg: ConstColor.purpleBg),
      IssueTypeModel(id: 't4', label: 'Handyman — General Maintenance', color: ConstColor.tenantIconColor, bg: ConstColor.tenantIconBg),
      IssueTypeModel(id: 't5', label: 'Roofer — Roofing', color: ConstColor.errorColor, bg: ConstColor.errorBg),
      IssueTypeModel(id: 't6', label: 'Carpenter — Carpentry', color: ConstColor.primaryColor, bg: ConstColor.infoBg),
      IssueTypeModel(id: 't7', label: 'Decorator — Painting & Decorating', color: ConstColor.purpleColor, bg: ConstColor.purpleBg),
    ];
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchContractors() async {
    contractors.value = [
      ContractorModel(id: 'c1', name: 'Electric Fix', roleLabel: 'Electrician', roleColor: ConstColor.purpleColor, isSuggested: true),
      ContractorModel(id: 'c2', name: 'Heating Co.', roleLabel: 'Heating engineer', roleColor: ConstColor.contractorIconColor),
      ContractorModel(id: 'c3', name: 'Plumber Pro', roleLabel: 'Plumber', roleColor: ConstColor.primaryColor),
    ];
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchIssues() async {
    final plumbing = const IssueTypeModel(id: 't1', label: 'Plumbing', color: ConstColor.primaryColor, bg: ConstColor.infoBg);
    issues.value = [
      MaintenanceIssueModel(
        id: '1',
        refCode: '#REQ-001',
        title: 'Paint peeling in hallway',
        description: 'Paint peeling near the entrance.',
        propertyName: '12 Park Lane',
        unitLabel: 'Flat 2A',
        tenantName: 'Sarah Johnson',
        tenantPhone: '+44 7700 900456',
        issueType: plumbing,
        priority: IssuePriority.low,
        status: IssueStatus.open,
        photoUrls: const [],
        videoCount: 0,
        reportedAgoLabel: '1d ago',
        tenantPays: false,
        isTenantReported: true,
      ),
      MaintenanceIssueModel(
        id: '2',
        refCode: '#REQ-009',
        title: 'Bathroom basin cracked',
        description: 'Crack in the bathroom basin — water pooling on the vanity. Tenant says it worsened overnight.',
        propertyName: '12 Park Lane',
        unitLabel: 'Flat 2A',
        tenantName: 'Sarah Johnson',
        tenantPhone: '+44 7700 900456',
        issueType: plumbing,
        priority: IssuePriority.urgent,
        status: IssueStatus.open,
        photoUrls: const ['assets/images/maintenance_photo_1.png', 'assets/images/maintenance_photo_2.png'],
        videoCount: 1,
        reportedAgoLabel: '4h ago',
        tenantPays: true,
        isTenantReported: true,
      ),
    ];
  }

  void applySearch(String value) => searchQuery.value = value;
  void selectFilterProperty(PropertyModel? property) {
    filterProperty.value = property;
    filterUnit.value = null;
  }
  void selectFilterUnit(UnitModel? unit) => filterUnit.value = unit;
  void selectFilterTab(int index) => selectedFilterTabIndex.value = index;

  void openDetail(MaintenanceIssueModel issue) {
    selectedIssue.value = issue;
    Get.toNamed(AppRoutes.maintenanceIssueDetailScreen);
  }

  void openAssignContractor() => Get.toNamed(AppRoutes.assignContractorScreen);

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void assignContractor(ContractorModel contractor) {
    final issue = selectedIssue.value;
    if (issue == null) return;
    final updated = issue.copyWith(status: IssueStatus.assigned, assignedContractor: contractor);
    selectedIssue.value = updated;
    final index = issues.indexWhere((i) => i.id == issue.id);
    if (index != -1) issues[index] = updated;
    Get.back();
    AppSnackBar.success('Contractor assigned');
  }

  void confirmCancelIssue() {
    final issue = selectedIssue.value;
    if (issue == null) return;
    ConfirmActionDialog.show(
      title: ConstString.cancelIssueTitle,
      message: 'Cancel "${issue.title}"?',
      confirmLabel: ConstString.cancelIssue,
      onConfirm: () => _cancelIssue(issue.id),
    );
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void _cancelIssue(String id) {
    issues.removeWhere((i) => i.id == id);
    selectedIssue.value = null;
    Get.back();
    AppSnackBar.success('Issue cancelled');
  }

  void setLocationType(IssueLocationType type) {
    formLocationType.value = type;
    formUnit.value = null;
    formCommunalArea.value = null;
  }

  Future<void> pickMedia() async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
        if (file != null) pickedMediaPath.value = file.path;
      },
      onGallery: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
        if (file != null) pickedMediaPath.value = file.path;
      },
    );
  }

  void removePickedMedia() => pickedMediaPath.value = null;

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> submitLogIssue() async {
    if (!canSubmitRx.value) return;
    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 1));

    final unitLabel = formLocationType.value == IssueLocationType.unit
        ? formUnit.value!.label.split(' · ').first
        : formCommunalArea.value!;

    issues.insert(
      0,
      MaintenanceIssueModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        refCode: '#REQ-${issues.length + 10}',
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        propertyName: formProperty.value!.name,
        unitLabel: unitLabel,
        tenantName: '-',
        tenantPhone: '-',
        issueType: formIssueType.value!,
        priority: formPriority.value,
        status: IssueStatus.open,
        photoUrls: pickedMediaPath.value != null ? [pickedMediaPath.value!] : const [],
        videoCount: 0,
        reportedAgoLabel: 'Just now',
        tenantPays: false,
        isTenantReported: false,
      ),
    );

    resetForm();
    isSubmitting.value = false;
    AppSnackBar.success('Issue logged successfully');
    Get.back();
  }

  void resetForm() {
    formProperty.value = null;
    formLocationType.value = IssueLocationType.unit;
    formUnit.value = null;
    formCommunalArea.value = null;
    titleController.clear();
    descriptionController.clear();
    formIssueType.value = null;
    formPriority.value = IssuePriority.medium;
    pickedMediaPath.value = null;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}