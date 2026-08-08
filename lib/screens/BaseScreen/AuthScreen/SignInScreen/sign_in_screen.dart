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
import '../Widget/auth_header_widget.dart';
import 'Controller/sign_in_screen_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInScreenController>(
      init: SignInScreenController(),
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
                    SizedBox(height: 40.h),
                    AuthHeaderWidget(
                      icon: AppImage(
                        path: "assets/images/app_logo.png", // TODO: add asset
                        width: 28.w,
                        height: 28.w,
                        fit: BoxFit.contain,
                      ),
                      title: ConstString.signInTitle,
                      subtitle: ConstString.signInSubtitle,
                    ),
                    SizedBox(height: 28.h),
                    CustomTextFormField(
                      fromTitle: ConstString.emailOrPhone,
                      textController: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomPasswordField(
                      fromTitle: ConstString.password,
                      textController: controller.passwordController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: controller.goToForgotPassword,
                        child: CustomText(
                          title: ConstString.forgotPassword,
                          textColor: ConstColor.primaryColor,
                          textSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                          () => CustomElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.onSignIn,
                        child: controller.isLoading.value
                            ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : CustomText(
                          title: ConstString.signIn,
                          textColor: Colors.white,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(child: Divider(color: ConstColor.bodyColor.withAlpha(60))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: CustomText(
                            title: ConstString.orContinueWith,
                            textColor: ConstColor.bodyColor,
                            textSize: 12.sp,
                          ),
                        ),
                        Expanded(child: Divider(color: ConstColor.bodyColor.withAlpha(60))),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      onPressed: controller.onGoogleSignIn,
                      isOutLined: true,
                      elevation: 0,
                      outLineColour: ConstColor.bodyColor,
                      icon: AppImage(
                        path: "assets/images/google.png", // TODO: add asset
                        width: 20.w,
                        height: 20.h,
                      ),
                      child: CustomText(
                        title: ConstString.google,
                        textColor: ConstColor.titleColor,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          title: ConstString.dontHaveAccount,
                          textColor: ConstColor.bodyColor,
                          textSize: 13.sp,
                        ),
                        TextButton(
                          onPressed: controller.goToSignUp,
                          child: CustomText(
                            title: ConstString.signUp,
                            textColor: ConstColor.primaryColor,
                            textSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
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