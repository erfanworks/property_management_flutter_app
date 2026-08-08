import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomPasswordField/custom_password_field.dart';
import '../../../../widget/text/custom_text.dart';
import '../Widget/auth_back_button.dart';
import '../Widget/auth_header_widget.dart';
import '../Widget/password_requirement_check_list.dart';
import 'Controller/create_new_password_screen_controller.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewPasswordScreenController>(
      init: CreateNewPasswordScreenController(),
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
                      icon: Icon(Icons.lock_outline_rounded, color: Colors.white, size: 26.sp),
                      title: ConstString.createNewPasswordTitle,
                      subtitle: ConstString.createNewPasswordSubtitle,
                    ),
                    SizedBox(height: 28.h),
                    CustomPasswordField(
                      fromTitle: ConstString.newPassword,
                      textController: controller.newPasswordController,
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
                        onPressed: controller.isLoading.value ? null : controller.onUpdatePassword,
                        child: controller.isLoading.value
                            ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                            : CustomText(
                          title: ConstString.updatePassword,
                          textColor: Colors.white,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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