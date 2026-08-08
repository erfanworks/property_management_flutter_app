import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../widget/text/custom_text.dart';
import '../Widget/auth_back_button.dart';
import '../Widget/auth_header_widget.dart';
import 'Controller/forgot_password_screen_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordScreenController>(
      init: ForgotPasswordScreenController(),
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
                    SizedBox(height: 30.h),
                    AuthHeaderWidget(
                      icon: Icon(Icons.mail_outline_rounded, color: Colors.white, size: 28.sp),
                      title: ConstString.forgotPasswordTitle,
                      subtitle: ConstString.forgotPasswordSubtitle,
                    ),
                    SizedBox(height: 28.h),
                    CustomTextFormField(
                      fromTitle: ConstString.emailOrPhone,
                      textController: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                          () => CustomElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.onSendCode,
                        child: controller.isLoading.value
                            ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                            : CustomText(
                          title: ConstString.sendVerificationCode,
                          textColor: Colors.white,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shield_outlined, size: 14.sp, color: ConstColor.bodyColor),
                        SizedBox(width: 6.w),
                        CustomText(
                          title: ConstString.codeExpiresIn5,
                          textColor: ConstColor.bodyColor,
                          textSize: 12.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          title: ConstString.rememberPassword,
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