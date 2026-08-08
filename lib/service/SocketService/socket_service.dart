// import 'dart:async';
// import 'dart:io' as IO;
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
//
// class SocketService extends GetxService {
//   static SocketService get to => Get.find();
//
//   IO.Socket? socket;
//   String? currentUserId;
//
//   // ── Reconnect state ───────────────────────────────────────────────────────
//   Timer? _reconnectTimer;
//   int _reconnectAttempts = 0;
//   static const int _maxReconnectAttempts = 10;
//   bool _intentionalDisconnect = false;
//
//   // ── Exponential backoff: 2s → 4s → 8s → 16s → 30s (max) ─────────────────
//   Duration get _nextReconnectDelay {
//     final seconds = (2 * (1 << _reconnectAttempts.clamp(0, 4))).clamp(2, 30);
//     return Duration(seconds: seconds);
//   }
//
//   final RxBool isConnected = false.obs;
//
//   Future<SocketService> init() async {
//     connect();
//     return this;
//   }
//
//   void connect() {
//     if (socket?.connected == true) return;
//
//     _cancelReconnectTimer();
//     socket?.dispose();
//
//     socket = IO.io(
//       // AppApiUrl.instance.socket,
//       IO.OptionBuilder()
//           .setTransports(['websocket', 'polling'])
//           .disableAutoConnect()
//           .setTimeout(10000)
//           .disableReconnection()
//           .build(),
//     );
//
//     socket!.connect();
//
//     socket!.onConnect((_) {
//       isConnected.value = true;
//       _reconnectAttempts = 0;
//       _cancelReconnectTimer();
//       debugPrint("✅ Socket Connected Successfully");
//
//       if (currentUserId != null) {
//         // ── User register করো ─────────────────────────────────────────────
//         socket!.emit("registerUser", currentUserId);
//         debugPrint("👤 User registered: $currentUserId");
//
//         // ── Dynamic event name দিয়ে notification listen করো ──────────────
//         final eventName = 'send-notification::$currentUserId';
//         debugPrint("👂 Listening to event: $eventName");
//
//         socket!.on(eventName, (data) {
//           debugPrint("🔔 Notification received: $data");
//
//           // Sound বাজাও
//           // NotificationSoundService.playNotificationSound();
//           //
//           // // Notification list refresh করো
//           // if (Get.isRegistered<UserNotificationPageController>()) {
//           //   Get.find<UserNotificationPageController>().refresh();
//           // }
//         });
//       }
//     });
//
//     socket!.onDisconnect((_) {
//       isConnected.value = false;
//       debugPrint("❌ Socket Disconnected");
//       if (!_intentionalDisconnect) _scheduleReconnect();
//     });
//
//     socket!.onError((error) {
//       debugPrint("⚠️ Socket Error: $error");
//       _scheduleReconnect();
//     });
//
//     socket!.onConnectError((error) {
//       isConnected.value = false;
//       debugPrint("⚠️ Socket Connect Error: $error");
//       _scheduleReconnect();
//     });
//   }
//
//   // ── Exponential backoff reconnect ─────────────────────────────────────────
//   void _scheduleReconnect() {
//     if (_intentionalDisconnect) return;
//     if (_reconnectAttempts >= _maxReconnectAttempts) {
//       debugPrint("🛑 Socket: max reconnect attempts reached. Stopping.");
//       return;
//     }
//     if (_reconnectTimer?.isActive == true) return;
//
//     final delay = _nextReconnectDelay;
//     _reconnectAttempts++;
//     debugPrint("🔄 Reconnect attempt $_reconnectAttempts in ${delay.inSeconds}s...");
//
//     _reconnectTimer = Timer(delay, () {
//       if (socket?.connected != true && !_intentionalDisconnect) {
//         connect();
//       }
//     });
//   }
//
//   void _cancelReconnectTimer() {
//     _reconnectTimer?.cancel();
//     _reconnectTimer = null;
//   }
//
//   // ── User set করো (Login এর পরে call করো) ─────────────────────────────────
//   void setUser(String userId) {
//     currentUserId = userId;
//     if (socket?.connected == true) {
//       socket!.emit("registerUser", userId);
//       debugPrint("🔄 User ID sent to socket: $userId");
//
//       // ── নতুন user এর event listen শুরু করো ───────────────────────────────
//       final eventName = 'send-notification::$userId';
//       debugPrint("👂 Listening to event: $eventName");
//
//       socket!.on(eventName, (data) {
//         debugPrint("🔔 Notification received: $data");
//         // NotificationSoundService.playNotificationSound();
//
//         // if (Get.isRegistered<UserNotificationPageController>()) {
//         //   Get.find<UserNotificationPageController>().refresh();
//         // }
//       });
//     } else {
//       connect();
//     }
//   }
//
//   // ── Intentional disconnect (Logout এর সময় call করো) ─────────────────────
//   void disconnect() {
//     _intentionalDisconnect = true;
//     _cancelReconnectTimer();
//
//     // ── Event listener সরাও ───────────────────────────────────────────────
//     if (currentUserId != null) {
//       socket?.off('send-notification::$currentUserId');
//       debugPrint("🔕 Stopped listening: send-notification::$currentUserId");
//     }
//
//     socket?.disconnect();
//     socket?.dispose();
//     socket = null;
//     isConnected.value = false;
//     currentUserId = null;
//   }
//
//   @override
//   void onClose() {
//     _intentionalDisconnect = true;
//     _cancelReconnectTimer();
//     socket?.dispose();
//     super.onClose();
//   }
// }
//
// // ── Notification Sound Service ─────────────────────────────────────────────
// // class NotificationSoundService {
// //   static final AudioPlayer _player = AudioPlayer();
// //
// //   static Future<void> playNotificationSound() async {
// //     try {
// //       await _player.stop();
// //       await _player.play(AssetSource('sounds/notification_sound.wav'));
// //       debugPrint("🔊 Sound played successfully");
// //     } catch (e) {
// //       debugPrint('🔇 Sound error: $e');
// //     }
// //   }
// // }