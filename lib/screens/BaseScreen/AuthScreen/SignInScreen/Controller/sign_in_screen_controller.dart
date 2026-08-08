import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';

class SignInScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> onSignIn() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // TODO: replace with Dio API call
    isLoading.value = false;

    // TODO: navigate to role-based home once backend/nav ready
    Get.offAllNamed(AppRoutes.navBar);
  }

  void onGoogleSignIn() {
    // TODO: integrate Google Sign-In
  }

  void goToForgotPassword() => Get.toNamed(AppRoutes.forgotPasswordScreen);

  void goToSignUp() => Get.toNamed(AppRoutes.signUpScreen);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}