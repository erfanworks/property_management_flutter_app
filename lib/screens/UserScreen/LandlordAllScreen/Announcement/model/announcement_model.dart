// lib/screens/UserScreen/LandlordAllScreen/Announcement/model/announcement_model.dart
enum AnnouncementAudience { entireProperty, selectedFlats }

class AnnouncementModel {
  final String id;
  final String title;
  final String message;
  final String propertyName;
  final String? imageUrl;
  final String sentToLabel;
  final String dateTimeLabel;
  final AnnouncementAudience audience;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.message,
    required this.propertyName,
    this.imageUrl,
    required this.sentToLabel,
    required this.dateTimeLabel,
    required this.audience,
  });
}