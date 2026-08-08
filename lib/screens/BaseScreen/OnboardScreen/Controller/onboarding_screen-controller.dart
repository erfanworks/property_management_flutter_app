import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/const_string.dart';
import '../../../../routes/app_routes/app_routes.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String subTitle;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

class OnboardingScreenController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingModel> pages = const [
    OnboardingModel(
      image: "assets/images/onboarding_img.png",
      title: ConstString.onboardingTitle1,
      subTitle: ConstString.onboardingSubTitle1,
    ),
    OnboardingModel(
      image: "assets/images/onboarding_img_2.png",
      title: ConstString.onboardingTitle2,
      subTitle: ConstString.onboardingSubTitle2,
    ),
    OnboardingModel(
      image: "assets/images/onboarding_img_3.png",
      title: ConstString.onboardingTitle3,
      subTitle: ConstString.onboardingSubTitle3,
    ),
  ];

  bool get isLastPage => currentPage.value == pages.length - 1;

  void onPageChanged(int index) => currentPage.value = index;

  void onNext() {
    if (isLastPage) {
      _goToRoleSelect();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void onSkip() => _goToRoleSelect();

  void _goToRoleSelect() => Get.offAllNamed(AppRoutes.roleSelectScreen);

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}