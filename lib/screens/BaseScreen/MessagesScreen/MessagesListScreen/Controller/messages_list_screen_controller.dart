import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../utils/app_role.dart';
import '../../Widget/conversation_tile.dart';
import '../../Widget/new_message_sheet.dart';

class MessagesListScreenController extends GetxController {
  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  bool get isContractor => selectedUserRole == AppUserType.contractor;

  late final List<ConversationModel> _allConversations =
  isContractor ? _contractorConversations : _sharedConversations;

  List<ConversationModel> get conversations {
    if (searchQuery.value.trim().isEmpty) return _allConversations;
    return _allConversations
        .where((c) => c.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void onSearchChanged(String value) => searchQuery.value = value;

  void onOpenConversation(ConversationModel conversation) {
    Get.toNamed(AppRoutes.chatDetailScreen, arguments: conversation);
  }

  void onComposeNewMessage() {
    Get.bottomSheet(
      NewMessageSheet(conversations: _allConversations, onSelect: onOpenConversation),
      isScrollControlled: true,
      backgroundColor: Colors.white,
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

// ─── Dummy data: Landlord & Tenant share this ───
final List<ConversationModel> _sharedConversations = [
  ConversationModel(
    id: '1',
    title: 'Sarah Johnson',
    isOnline: true,
    subtitleLines: const ['Hi, the maintenance issue has been fixed!'],
    timestamp: '10:30 AM',
    unreadCount: 2,
  ),
  ConversationModel(
    id: '2',
    title: 'Plumber Pro',
    isOnline: true,
    subtitleLines: const ['Please let me know when you are free for...'],
    timestamp: '9:15 AM',
    unreadCount: 1,
  ),
  ConversationModel(
    id: '3',
    title: 'David Wilson',
    subtitleLines: const ['Thanks for the update.'],
    timestamp: 'Yesterday',
  ),
  ConversationModel(
    id: '4',
    title: 'Electric Fixers',
    subtitleLines: const ['The issue has been fixed.'],
    timestamp: 'Yesterday',
  ),
  ConversationModel(
    id: '5',
    title: 'Michael Lee',
    subtitleLines: const ['Can we schedule an inspection?'],
    timestamp: '2d ago',
  ),
  ConversationModel(
    id: '6',
    title: 'Heating Experts',
    subtitleLines: const ['Invoice uploaded.'],
    timestamp: '2d ago',
  ),
];

// ─── Dummy data: Contractor ───
final List<ConversationModel> _contractorConversations = const [
  ConversationModel(
    id: 'j1',
    title: 'Window latch broken',
    tag: 'Job chat',
    isGroup: true,
    subtitleLines: ['Job chat started', '2 members · 88 King Street · Main Flat'],
    timestamp: 'Just now',
  ),
  ConversationModel(
    id: '7',
    title: 'John Smith',
    isOnline: true,
    subtitleLines: ['Coordinate jobs and access'],
    timestamp: 'Now',
  ),
  ConversationModel(
    id: 'j2',
    title: 'Tap replaced',
    tag: 'Job chat',
    isGroup: true,
    subtitleLines: ['Job chat started', '3 members · 45 Queens Road · Flat 1A'],
    timestamp: 'Just now',
  ),
  ConversationModel(
    id: 'j3',
    title: 'Light flickering',
    tag: 'Job chat',
    isGroup: true,
    subtitleLines: ['Job chat started', '3 members · 15 Victoria Ave · Flat 2A'],
    timestamp: 'Just now',
  ),
  ConversationModel(
    id: 'j4',
    title: 'Radiator not heating',
    tag: 'Job chat',
    isGroup: true,
    subtitleLines: ['Job chat started', '3 members · 15 Victoria Ave · Flat 2A'],
    timestamp: 'Just now',
  ),
  ConversationModel(
    id: 'j5',
    title: 'Boiler not working',
    tag: 'Job chat',
    isGroup: true,
    subtitleLines: ['Job chat started', '3 members · 45 Queens Road · Flat 1A'],
    timestamp: 'Just now',
  ),
  ConversationModel(
    id: 'j6',
    title: 'Kitchen sink leaking',
    tag: 'Job chat',
    isGroup: true,
    subtitleLines: ['Job chat started', '3 members · 12 Park Lane · Flat 2A'],
    timestamp: 'Just now',
  ),
  ConversationModel(
    id: '8',
    title: 'Sarah Johnson',
    isOnline: true,
    subtitleLines: ["I'll be home after 1 PM today."],
    timestamp: '10:28 AM',
    unreadCount: 1,
  ),
];