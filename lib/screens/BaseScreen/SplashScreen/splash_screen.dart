import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constant/const_string.dart';
import '../../../widget/AppImage/app_image.dart';
import '../../../widget/text/custom_text.dart';
import 'Controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splash_img.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Obx(
                  () => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ─── Logo: bounce-in ───────────────
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOut,
                        opacity: controller.animation.value,
                        child: AnimatedScale(
                          scale: controller.animation.value,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOutBack,
                          child: AppImage(
                            path: "assets/images/app_logo.png",
                            width: 80.w,
                            height: 86.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // ─── Title: delayed fade + slide-up ─
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 900),
                        curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
                        opacity: controller.animation.value,
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 900),
                          curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
                          offset: Offset(0, (1 - controller.animation.value) * 0.3),
                          child: CustomText(
                            title: ConstString.splashTitle,
                            textSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}