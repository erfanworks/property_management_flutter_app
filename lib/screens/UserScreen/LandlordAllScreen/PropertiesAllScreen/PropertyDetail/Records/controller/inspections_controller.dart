// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/controller/inspections_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../../HomeTabAllScreen/Maintenance/controller/maintenance_controller.dart';
import '../../../../HomeTabAllScreen/Maintenance/model/maintenance_issue_model.dart';
import '../model/inspection_model.dart';

class InspectionsController extends GetxController {
  final RxList<InspectionRecordModel> inspections = <InspectionRecordModel>[].obs;
  final Rx<InspectionRecordModel?> selectedReport = Rx<InspectionRecordModel?>(null);

  final RxList<String> areaOptions = <String>[].obs;
  final Rx<String?> selectedArea = Rx<String?>(null);
  final RxList<RoomChecklistItemModel> checklist = <RoomChecklistItemModel>[].obs;
  final notesController = TextEditingController();
  final RxList<String> attachedPhotos = <String>[].obs;

  int get checkedCount => checklist.where((r) => r.status != RoomCheckStatus.none).length;
  bool get hasDefect => checklist.any((r) => r.status == RoomCheckStatus.defect);

  @override
  void onInit() {
    super.onInit();
    fetchInspections();
    resetConductForm();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchInspections() async {
    inspections.value = const [
      InspectionRecordModel(id: 'i1', areaLabel: 'Flat 2A', typeLabel: 'Routine Property Inspection', dateLabel: '15 Jan 2024', addressLabel: 'London, SW1A 1AA', inspectorNotes: 'Flat in excellent condition. Smoke alarms and boiler pressure verified.', photoUrls: ['assets/images/insp1.png', 'assets/images/insp2.png', 'assets/images/insp3.png']),
      InspectionRecordModel(id: 'i2', areaLabel: 'Flat 1', typeLabel: 'Move-in Tenancy Check', dateLabel: '1 Sept 2023'),
      InspectionRecordModel(id: 'i3', areaLabel: 'Flat 2B', typeLabel: 'Routine Property Inspection', dateLabel: '1 Jun 2024'),
      InspectionRecordModel(id: 'i4', areaLabel: 'Flat 3', typeLabel: 'Routine Property Inspection', dateLabel: '1 Feb 2024'),
      InspectionRecordModel(id: 'i5', areaLabel: 'Communal Building Areas', typeLabel: 'Building Safety Audit', dateLabel: '10 Jan 2025', isCommunal: true),
    ];
  }

  void resetConductForm() {
    areaOptions.value = ['Flat 1 · Sarah Johnson', 'Flat 2A', 'Flat 2B', 'Communal Areas'];
    selectedArea.value = areaOptions.first;
    checklist.value = [
      RoomChecklistItemModel(roomName: 'Kitchen', icon: Icons.kitchen_outlined),
      RoomChecklistItemModel(roomName: 'Living room', icon: Icons.weekend_outlined),
      RoomChecklistItemModel(roomName: 'Bedroom 1', icon: Icons.bed_outlined),
      RoomChecklistItemModel(roomName: 'Bedroom 2', icon: Icons.bed_outlined),
      RoomChecklistItemModel(roomName: 'Bathroom', icon: Icons.bathtub_outlined),
      RoomChecklistItemModel(roomName: 'Hallway', icon: Icons.door_front_door_outlined),
    ];
    notesController.clear();
    attachedPhotos.clear();
  }

  void openConduct() {
    resetConductForm();
    Get.toNamed(AppRoutes.conductInspectionScreen);
  }

  void openReport(InspectionRecordModel r) {
    selectedReport.value = r;
    Get.toNamed(AppRoutes.inspectionReportScreen);
  }

  void selectArea(String? area) => selectedArea.value = area;

  void setRoomStatus(String roomName, RoomCheckStatus status) {
    final index = checklist.indexWhere((r) => r.roomName == roomName);
    if (index != -1) {
      checklist[index].status = status;
      checklist.refresh();
    }
  }

  void markAllPass() {
    for (final r in checklist) {
      r.status = RoomCheckStatus.pass;
    }
    checklist.refresh();
  }

  void addPhotoPlaceholder() => attachedPhotos.add('photo_${attachedPhotos.length + 1}');

  /// Cross-feature link: pre-fills Maintenance's Log Issue form for the defect room.
  void logRepairForDefect(String roomName) {
    final maintenance = Get.isRegistered<MaintenanceController>() ? Get.find<MaintenanceController>() : Get.put(MaintenanceController());
    maintenance.titleController.text = '$roomName issue found during inspection';
    maintenance.descriptionController.text = notesController.text.trim().isEmpty ? 'Defect flagged during property inspection in $roomName.' : notesController.text.trim();
    maintenance.formPriority.value = IssuePriority.high;
    Get.toNamed(AppRoutes.logIssueScreen);
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void saveInspectionReport() {
    inspections.insert(0, InspectionRecordModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      areaLabel: selectedArea.value ?? '-',
      typeLabel: 'Routine Property Inspection',
      dateLabel: 'Just now',
      inspectorNotes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
    ));
    AppSnackBar.success('Inspection report saved');
    Get.back();
  }
}