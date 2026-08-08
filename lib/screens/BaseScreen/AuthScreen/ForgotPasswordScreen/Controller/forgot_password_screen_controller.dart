import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';

class ForgotPasswordScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> onSendCode() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // TODO: replace with Dio API call
    isLoading.value = false;

    Get.toNamed(
      AppRoutes.otpVerificationScreen,
      arguments: {'email': emailController.text.trim(), 'purpose': 'resetPassword'},
    );
  }

  void goToSignIn() => Get.back();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
