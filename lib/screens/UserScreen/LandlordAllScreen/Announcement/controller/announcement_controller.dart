// lib/screens/UserScreen/LandlordAllScreen/Announcement/controller/announcement_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../model/announcement_model.dart';
import '../model/property_model.dart';

class AnnouncementController extends GetxController {
  // ── List ──
  final RxList<AnnouncementModel> announcements = <AnnouncementModel>[].obs;

  // ── Detail ──
  final Rx<AnnouncementModel?> selectedAnnouncement = Rx<AnnouncementModel?>(null);

  // ── Create form ──
  final RxList<PropertyModel> properties = <PropertyModel>[].obs;
  final Rx<PropertyModel?> selectedProperty = Rx<PropertyModel?>(null);
  final Rx<AnnouncementAudience> audience = AnnouncementAudience.entireProperty.obs;
  final RxSet<String> selectedFlatIds = <String>{}.obs;
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  final Rx<String?> pickedImagePath = Rx<String?>(null);
  final isSending = false.obs;
  final canSendRx = false.obs;

  bool get allFlatsSelected =>
      selectedProperty.value != null && selectedFlatIds.length == selectedProperty.value!.flats.length;

  @override
  void onInit() {
    super.onInit();
    fetchAnnouncements();
    fetchProperties();
    titleController.addListener(_validate);
    messageController.addListener(_validate);
    ever(selectedProperty, (_) => _validate());
    ever(audience, (_) => _validate());
    ever(selectedFlatIds, (_) => _validate());
  }

  void _validate() {
    canSendRx.value = selectedProperty.value != null &&
        titleController.text.trim().isNotEmpty &&
        messageController.text.trim().isNotEmpty &&
        (audience.value == AnnouncementAudience.entireProperty || selectedFlatIds.isNotEmpty);
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchAnnouncements() async {
    announcements.value = [
      const AnnouncementModel(
        id: '1',
        title: 'Boiler service next week',
        message: 'Heating Co. will access units on Mon 28 Jul, 9-11am. Please ensure someone is home or leave a key with reception.',
        propertyName: '12 Park Lane',
        imageUrl: 'assets/images/announcement_kitchen.png',
        sentToLabel: 'All flats in 12 Park Lane',
        dateTimeLabel: 'Jul 22, 2026 · 15:07',
        audience: AnnouncementAudience.entireProperty,
      ),
      const AnnouncementModel(
        id: '2',
        title: 'Rubbish collection change',
        message: 'Collection day moves to Wednesdays starting next week.',
        propertyName: '45 Queens Road',
        sentToLabel: 'All flats in 45 Queens Road',
        dateTimeLabel: 'Jul 18, 2026',
        audience: AnnouncementAudience.entireProperty,
      ),
      const AnnouncementModel(
        id: '3',
        title: 'Garden maintenance',
        message: 'Gardeners will visit on Jul 16 for seasonal upkeep.',
        propertyName: '88 King Street',
        imageUrl: 'assets/images/announcement_garden.png',
        sentToLabel: 'All flats in 88 King Street',
        dateTimeLabel: 'Jul 15, 2026',
        audience: AnnouncementAudience.entireProperty,
      ),
    ];
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchProperties() async {
    properties.value = const [
      PropertyModel(id: 'p1', name: '12 Park Lane', flats: [
        FlatModel(id: 'f1', name: 'Flat 1A', statusLabel: 'Vacant — no tenants notified'),
        FlatModel(id: 'f2', name: 'Flat 1B', statusLabel: 'Vacant — no tenants notified'),
        FlatModel(id: 'f3', name: 'Flat 2A', statusLabel: '1 active tenant'),
        FlatModel(id: 'f4', name: 'Flat 2B', statusLabel: '1 active tenant'),
      ]),
      PropertyModel(id: 'p2', name: '45 Queens Road', flats: []),
      PropertyModel(id: 'p3', name: '88 King Street', flats: []),
      PropertyModel(id: 'p4', name: '15 Victoria Ave', flats: []),
    ];
  }

  void openDetail(AnnouncementModel item) {
    selectedAnnouncement.value = item;
    Get.toNamed(AppRoutes.announcementDetailScreen);
  }

  void selectProperty(PropertyModel? property) {
    selectedProperty.value = property;
    selectedFlatIds.clear();
    audience.value = AnnouncementAudience.entireProperty;
  }

  void setAudience(AnnouncementAudience value) {
    audience.value = value;
    if (value == AnnouncementAudience.entireProperty) selectedFlatIds.clear();
  }

  void toggleFlat(String flatId) {
    if (selectedFlatIds.contains(flatId)) {
      selectedFlatIds.remove(flatId);
    } else {
      selectedFlatIds.add(flatId);
    }
  }

  void toggleAllFlats() {
    final flats = selectedProperty.value?.flats ?? [];
    selectedFlatIds.value = allFlatsSelected ? {} : flats.map((f) => f.id).toSet();
  }

  Future<void> pickImage() async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
        if (file != null) pickedImagePath.value = file.path;
      },
      onGallery: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
        if (file != null) pickedImagePath.value = file.path;
      },
    );
  }

  void removePickedImage() => pickedImagePath.value = null;

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> sendAnnouncement() async {
    if (!canSendRx.value) return;
    isSending.value = true;
    await Future.delayed(const Duration(seconds: 1));

    final sentToLabel = audience.value == AnnouncementAudience.entireProperty
        ? 'All flats in ${selectedProperty.value!.name}'
        : selectedProperty.value!.flats
        .where((f) => selectedFlatIds.contains(f.id))
        .map((f) => f.name)
        .join(', ');

    announcements.insert(
      0,
      AnnouncementModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text.trim(),
        message: messageController.text.trim(),
        propertyName: selectedProperty.value!.name,
        imageUrl: pickedImagePath.value,
        sentToLabel: sentToLabel,
        dateTimeLabel: 'Just now',
        audience: audience.value,
      ),
    );

    resetForm();
    isSending.value = false;
    AppSnackBar.success('Announcement sent successfully');
    Get.back();
  }

  void resetForm() {
    selectedProperty.value = null;
    audience.value = AnnouncementAudience.entireProperty;
    selectedFlatIds.clear();
    titleController.clear();
    messageController.clear();
    pickedImagePath.value = null;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> deleteAnnouncement(String id) async {
    announcements.removeWhere((a) => a.id == id);
    Get.back();
    AppSnackBar.success('Announcement deleted');
  }

  @override
  void onClose() {
    titleController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
