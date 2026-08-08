import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/text/custom_text.dart';
import '../Widget/auth_back_button.dart';
import '../Widget/auth_header_widget.dart';
import 'Controller/otp_verification_screen_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 46.w,
      height: 50.h,
      textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: ConstColor.titleColor),
      decoration: BoxDecoration(
        border: Border.all(color: ConstColor.bodyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
    final focusedPinTheme = PinTheme(
      width: 46.w,
      height: 50.h,
      textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: ConstColor.titleColor),
      decoration: BoxDecoration(
        border: Border.all(color: ConstColor.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    return GetBuilder<OtpVerificationScreenController>(
      init: OtpVerificationScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 12.h),
                  const Align(alignment: Alignment.centerLeft, child: AuthBackButton()),
                  SizedBox(height: 30.h),
                  AuthHeaderWidget(
                    icon: Icon(Icons.vpn_key_outlined, color: Colors.white, size: 26.sp),
                    title: ConstString.otpTitle,
                    subtitle: "${ConstString.otpSubtitlePrefix}${controller.email}",
                  ),
                  SizedBox(height: 28.h),
                  Pinput(
                    length: 6,
                    controller: controller.otpController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    onCompleted: (_) => controller.onVerify(),
                  ),
                  SizedBox(height: 16.h),
                  Obx(
                        () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          title: ConstString.didntGetCode,
                          textColor: ConstColor.bodyColor,
                          textSize: 13.sp,
                        ),
                        GestureDetector(
                          onTap: controller.onResendCode,
                          child: CustomText(
                            title: controller.secondsRemaining.value > 0
                                ? "${ConstString.resendCode} · 00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}"
                                : ConstString.resendCode,
                            textColor: controller.secondsRemaining.value > 0
                                ? ConstColor.bodyColor
                                : ConstColor.primaryColor,
                            textSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Obx(
                        () => CustomElevatedButton(
                      onPressed: controller.isLoading.value ? null : controller.onVerify,
                      child: controller.isLoading.value
                          ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                          : CustomText(
                        title: ConstString.verify,
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
        );
      },
    );
  }
}