import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomPasswordField/custom_password_field.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../widget/text/custom_text.dart';
import '../Widget/auth_back_button.dart';
import '../Widget/auth_header_widget.dart';
import '../Widget/password_requirement_check_list.dart';
import 'Controller/sign_up_screen_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpScreenController>(
      init: SignUpScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 12.h),
                    const Align(alignment: Alignment.centerLeft, child: AuthBackButton()),
                    SizedBox(height: 20.h),
                    AuthHeaderWidget(
                      icon: AppImage(
                        path: "assets/images/app_logo.png", // TODO: add asset
                        width: 28.w,
                        height: 28.w,
                        fit: BoxFit.contain,
                      ),
                      title: ConstString.createAccountTitle,
                      subtitle: ConstString.createAccountSubtitle,
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      fromTitle: ConstString.fullName,
                      textController: controller.nameController,
                      textInputAction: TextInputAction.next,
                    ),
                    CustomTextFormField(
                      fromTitle: ConstString.emailAddress,
                      textController: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    CustomPasswordField(
                      fromTitle: ConstString.password,
                      textController: controller.passwordController,
                      onChanged: controller.onPasswordChanged,
                    ),
                    CustomPasswordField(
                      fromTitle: ConstString.confirmPassword,
                      textController: controller.confirmPasswordController,
                      validator: controller.confirmPasswordValidator,
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                          () => PasswordRequirementChecklist(
                        hasMinLength: controller.hasMinLength.value,
                        hasNumber: controller.hasNumber.value,
                        hasUppercase: controller.hasUppercase.value,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(
                          () => CustomElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.onCreateAccount,
                        child: controller.isLoading.value
                            ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                            : CustomText(
                          title: ConstString.createAccount,
                          textColor: Colors.white,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          title: ConstString.alreadyHaveAccount,
                          textColor: ConstColor.bodyColor,
                          textSize: 13.sp,
                        ),
                        TextButton(
                          onPressed: controller.goToSignIn,
                          child: CustomText(
                            title: ConstString.signIn,
                            textColor: ConstColor.primaryColor,
                            textSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}