import 'package:get/get.dart';
import '../../../../routes/app_routes/app_routes.dart';
import '../../../../service/storage/storage_services.dart';

class SplashScreenController extends GetxController {

  RxDouble animation = 0.0.obs;

  Future<void> onAppInitialDataLoad() async {
    try {
      animation.value = 0;
      await Future.delayed(const Duration(milliseconds: 500));
      animation.value = 1;

      await Future.delayed(const Duration(seconds: 3));

      final isFirstTime = await StorageServices.instance.getAppFirstTime();
      final token = await StorageServices.instance.getToken();

      if (isFirstTime) {
        Get.offAllNamed(AppRoutes.onboardingScreen);
      } else if (token.isNotEmpty) {
        // Get.offAllNamed(AppRoutes.navBar);
      } else {
        // Get.offAllNamed(AppRoutes.signInScreen);
      }

    } catch (e) {
      // Get.offAllNamed(AppRoutes.signInScreen);
    }
  }

  @override
  void onInit() {
    super.onInit();
    onAppInitialDataLoad();
  }
}