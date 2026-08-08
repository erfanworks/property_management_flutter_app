import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constant/const_color.dart';
import '../../../constant/const_string.dart';
import '../../../widget/AppImage/app_image.dart';
import '../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../widget/text/custom_text.dart';
import 'Controller/onboarding_screen-controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingScreenController>(
      init: OnboardingScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                _SkipRow(controller: controller),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.pages.length,
                    onPageChanged: controller.onPageChanged,
                    itemBuilder: (_, index) =>
                        _OnboardingPage(model: controller.pages[index]),
                  ),
                ),
                _BottomSection(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Skip Row ─────────────────────────────
class _SkipRow extends StatelessWidget {
  final OnboardingScreenController controller;

  const _SkipRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: 8.h, right: 20.w),
        child: TextButton(
          onPressed: controller.onSkip,
          child: CustomText(
            title: ConstString.skip,
            textColor: ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ─── Single Page ──────────────────────────
class _OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const _OnboardingPage({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AppImage(path: model.image, fit: BoxFit.contain),
          ),
          SizedBox(height: 32.h),
          CustomText(
            title: model.title,
            textSize: 22.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.titleColor,
            textAlign: TextAlign.center,
            maxLine: 2,
          ),
          SizedBox(height: 10.h),
          CustomText(
            title: model.subTitle,
            textSize: 14.sp,
            textColor: ConstColor.bodyColor,
            textAlign: TextAlign.center,
            maxLine: 3,
          ),
        ],
      ),
    );
  }
}

// ─── Indicator + Next/Get Started Button ──
class _BottomSection extends StatelessWidget {
  final OnboardingScreenController controller;

  const _BottomSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 20.h),
      child: Column(
        children: [
          SmoothPageIndicator(
            controller: controller.pageController,
            count: controller.pages.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8.h,
              dotWidth: 8.w,
              expansionFactor: 3,
              activeDotColor: ConstColor.primaryColor,
              dotColor: ConstColor.bodyColor.withAlpha(60),
            ),
          ),
          SizedBox(height: 20.h),
          Obx(
                () => CustomElevatedButton(
              onPressed: controller.onNext,
              child: CustomText(
                title: controller.isLastPage
                    ? ConstString.getStarted
                    : ConstString.next,
                textColor: Colors.white,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}