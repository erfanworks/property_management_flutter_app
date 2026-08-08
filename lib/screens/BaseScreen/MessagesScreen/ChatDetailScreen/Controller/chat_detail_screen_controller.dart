import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../Widget/chat_bubble.dart';
import '../../Widget/chat_options_sheet.dart';
import '../../Widget/conversation_tile.dart';

class ChatDetailScreenController extends GetxController {
  final messageController = TextEditingController();
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;

  late final ConversationModel conversation;

  @override
  void onInit() {
    super.onInit();
    conversation = Get.arguments is ConversationModel
        ? Get.arguments as ConversationModel
        : const ConversationModel(id: '', title: 'Chat', subtitleLines: []);

    // TODO: replace with real chat history from API
    messages.addAll([
      ChatMessageModel(
        text: "Hi, the kitchen sink is leaking again. Could you send someone?",
        time: "10:15 AM",
      ),
      ChatMessageModel(
        text: "Thanks Sarah, I'll send a plumber today before 2pm.",
        time: "10:20 AM",
        isMe: true,
        status: "Sent",
      ),
      ChatMessageModel(
        text: "The maintenance issue has been fixed! Thank you 🙏",
        time: "10:30 AM",
      ),
    ]);
  }

  void onChatOptions() {
    Get.bottomSheet(
      ChatOptionsSheet(
        onMute: () {
          Get.back();
          AppSnackBar.message("Notifications muted"); // TODO: call mute API
        },
        onClearMessages: () {
          Get.back();
          messages.clear(); // TODO: clear via API too
        },
        onDeleteChat: () {
          Get.back();
          Get.back(); // close sheet + chat, back to list
          // TODO: call delete-chat API
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
    );
  }

  void onSend() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add(
      ChatMessageModel(text: text, time: 'Now', isMe: true, status: 'Sent'),
    );
    messageController.clear();

    // TODO: send message via Dio API / socket
  }

  void onCall() => AppSnackBar.message(
    "Calling ${conversation.title}...",
  ); // TODO: integrate real call

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
