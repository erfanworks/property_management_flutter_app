import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_string.dart';
import '../../../../routes/app_routes/app_routes.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/text/custom_text.dart';
import '../Widget/auth_header_widget.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthHeaderWidget(
                  icon: Icon(Icons.verified_user_outlined, color: Colors.white, size: 26.sp),
                  title: ConstString.passwordUpdatedTitle,
                  subtitle: ConstString.passwordUpdatedSubtitle,
                ),
                SizedBox(height: 28.h),
                CustomElevatedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.signInScreen),
                  child: CustomText(
                    title: ConstString.signIn,
                    textColor: Colors.white,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}