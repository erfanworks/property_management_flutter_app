import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';

class OtpVerificationScreenController extends GetxController {
  final otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxInt secondsRemaining = 59.obs;
  Timer? _timer;

  late final String email;
  late final String purpose; // 'resetPassword' | 'signUp'

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    email = args['email'] ?? '';
    purpose = args['purpose'] ?? 'resetPassword';
    _startTimer();
  }

  void _startTimer() {
    secondsRemaining.value = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  Future<void> onVerify() async {
    if (otpController.text.trim().length != 6) {
      AppSnackBar.error("Enter the 6-digit code");
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // TODO: replace with Dio API call
    isLoading.value = false;

    if (purpose == 'resetPassword') {
      Get.toNamed(AppRoutes.createNewPasswordScreen);
    } else {
      AppSnackBar.success("Account created. Please sign in.");
      Get.offAllNamed(AppRoutes.signInScreen);
    }
  }

  void onResendCode() {
    if (secondsRemaining.value > 0) return;
    otpController.clear();
    _startTimer();
    // TODO: trigger resend-code API call
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}