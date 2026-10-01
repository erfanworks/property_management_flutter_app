// lib/screens/UserScreen/LandlordAllScreen/SmartReminders/model/smart_reminder_model.dart
enum ReminderCategory { overdue, dueSoon }

class SmartReminderModel {
  final String id;
  final String title;
  final String propertyName;
  final String? flatLabel;
  final DateTime expiryDate;
  final String expiryDateLabel;
  final String daysLateLabel;
  final ReminderCategory category;

  const SmartReminderModel({
    required this.id, required this.title, required this.propertyName, this.flatLabel,
    required this.expiryDate, required this.expiryDateLabel, required this.daysLateLabel, required this.category,
  });
}