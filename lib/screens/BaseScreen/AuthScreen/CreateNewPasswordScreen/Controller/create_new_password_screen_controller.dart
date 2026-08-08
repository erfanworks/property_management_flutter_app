import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';

class CreateNewPasswordScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RxBool isLoading = false.obs;

  final RxBool hasMinLength = false.obs;
  final RxBool hasNumber = false.obs;
  final RxBool hasUppercase = false.obs;

  void onPasswordChanged(String value) {
    hasMinLength.value = value.length >= 8;
    hasNumber.value = value.contains(RegExp(r'[0-9]'));
    hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) return "This field is required";
    if (value != newPasswordController.text) return "Passwords do not match";
    return null;
  }

  Future<void> onUpdatePassword() async {
    if (!formKey.currentState!.validate()) return;
    if (!(hasMinLength.value && hasNumber.value && hasUppercase.value)) return;

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // TODO: replace with Dio API call
    isLoading.value = false;

    Get.offNamed(AppRoutes.passwordUpdatedScreen);
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}