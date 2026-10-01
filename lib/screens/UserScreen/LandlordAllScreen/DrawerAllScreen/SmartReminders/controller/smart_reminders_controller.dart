// lib/screens/UserScreen/LandlordAllScreen/SmartReminders/controller/smart_reminders_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../model/smart_reminder_model.dart';

class SmartRemindersController extends GetxController {
  final RxList<SmartReminderModel> reminders = <SmartReminderModel>[].obs;
  final RxList<String> properties = <String>[].obs;
  final Rx<String?> selectedProperty = Rx<String?>(null);
  final RxInt selectedTabIndex = 0.obs; // 0=All 1=Overdue 2=Due Soon
  final Rx<SmartReminderModel?> selectedReminder = Rx<SmartReminderModel?>(null);

  // Add form
  final titleController = TextEditingController();
  final Rx<String?> formProperty = Rx<String?>(null);
  final Rx<DateTime?> formDueDate = Rx<DateTime?>(null);
  final isSaving = false.obs;

  int get overdueCount => reminders.where((r) => r.category == ReminderCategory.overdue).length;
  int get dueSoonCount => reminders.where((r) => r.category == ReminderCategory.dueSoon).length;

  List<SmartReminderModel> get filteredReminders {
    var list = reminders;
    if (selectedProperty.value != null) list = list.where((r) => r.propertyName == selectedProperty.value).toList().obs;
    if (selectedTabIndex.value == 1) return list.where((r) => r.category == ReminderCategory.overdue).toList();
    if (selectedTabIndex.value == 2) return list.where((r) => r.category == ReminderCategory.dueSoon).toList();
    return list;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProperties();
    fetchReminders();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchProperties() async {
    properties.value = ['12 Park Lane', '45 Queens Road', '88 King Street', '15 Victoria Ave'];
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchReminders() async {
    reminders.value = [
      SmartReminderModel(id: 'r1', title: 'Gas Certificate Expiry', propertyName: '45 Queens Road', expiryDate: DateTime(2025, 10, 2), expiryDateLabel: '2 Oct 2025', daysLateLabel: '359 days late', category: ReminderCategory.overdue),
      SmartReminderModel(id: 'r2', title: 'Gas Certificate Expiry', propertyName: '12 Park Lane', expiryDate: DateTime(2025, 12, 16), expiryDateLabel: '16 Dec 2025', daysLateLabel: '289 days late', category: ReminderCategory.overdue),
      SmartReminderModel(id: 'r3', title: 'Smoke Alarm Expiry', propertyName: '12 Park Lane', expiryDate: DateTime(2026, 1, 15), expiryDateLabel: '15 Jan 2026', daysLateLabel: '284 days late', category: ReminderCategory.overdue),
      SmartReminderModel(id: 'r4', title: 'Heat Alarm Expiry', propertyName: '12 Park Lane', expiryDate: DateTime(2026, 1, 15), expiryDateLabel: '15 Jan 2026', daysLateLabel: '284 days late', category: ReminderCategory.overdue),
      SmartReminderModel(id: 'r5', title: 'CO₂ Alarm Expiry', propertyName: '12 Park Lane', expiryDate: DateTime(2026, 1, 15), expiryDateLabel: '15 Jan 2026', daysLateLabel: '284 days late', category: ReminderCategory.overdue),
      SmartReminderModel(id: 'r6', title: 'CO Alarm Expiry', propertyName: '12 Park Lane', expiryDate: DateTime(2026, 1, 15), expiryDateLabel: '15 Jan 2026', daysLateLabel: '284 days late', category: ReminderCategory.overdue),
      SmartReminderModel(id: 'r7', title: 'Gas Certificate Expiry', propertyName: '88 King Street', expiryDate: DateTime(2026, 1, 20), expiryDateLabel: '20 Jan 2026', daysLateLabel: '279 days late', category: ReminderCategory.overdue),
      SmartReminderModel(id: 'r8', title: 'Smoke Alarm Expiry', propertyName: '45 Queens Road', expiryDate: DateTime(2026, 3, 10), expiryDateLabel: '10 Mar 2026', daysLateLabel: '230 days late', category: ReminderCategory.dueSoon),
      SmartReminderModel(id: 'r9', title: 'Heat Alarm Expiry', propertyName: '45 Queens Road', expiryDate: DateTime(2026, 3, 10), expiryDateLabel: '10 Mar 2026', daysLateLabel: '230 days late', category: ReminderCategory.dueSoon),
    ];
  }

  void selectProperty(String? p) => selectedProperty.value = p;
  void selectTab(int index) => selectedTabIndex.value = index;

  void openDetail(SmartReminderModel r) {
    selectedReminder.value = r;
    Get.toNamed(AppRoutes.smartReminderDetailScreen);
  }

  void openAdd() {
    titleController.clear();
    formProperty.value = null;
    formDueDate.value = null;
    Get.toNamed(AppRoutes.addSmartReminderScreen);
  }

  Future<void> pickDueDate(BuildContext context) async {
    final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2100));
    if (picked != null) formDueDate.value = picked;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void saveReminder() {
    if (titleController.text.trim().isEmpty || formProperty.value == null || formDueDate.value == null) return;
    isSaving.value = true;
    final d = formDueDate.value!;
    reminders.insert(0, SmartReminderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text.trim(),
      propertyName: formProperty.value!,
      expiryDate: d,
      expiryDateLabel: '${d.day} ${_monthName(d.month)} ${d.year}',
      daysLateLabel: 'Upcoming',
      category: ReminderCategory.dueSoon,
    ));
    isSaving.value = false;
    AppSnackBar.success('Smart reminder saved');
    Get.back();
  }

  String _monthName(int m) => const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m - 1];
}