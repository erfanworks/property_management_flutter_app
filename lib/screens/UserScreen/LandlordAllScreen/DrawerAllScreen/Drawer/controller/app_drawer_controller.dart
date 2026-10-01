// lib/screens/UserScreen/LandlordAllScreen/Drawer/controller/app_drawer_controller.dart
import 'package:get/get.dart';
import '../../../../../../routes/app_routes/app_routes.dart';
import '../model/drawer_profile_model.dart';

class AppDrawerController extends GetxController {
  final Rx<DrawerProfileModel> profile = const DrawerProfileModel(name: 'John Smith', roleLabel: 'Landlord').obs;

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void openSmartReminders() {
    Get.back();
    Get.toNamed(AppRoutes.smartRemindersScreen);
  }

  void openTenants() {
    Get.back();
    Get.toNamed(AppRoutes.tenantsDirectoryScreen);
  }

  void openContractors() {
    Get.back();
    Get.toNamed(AppRoutes.contractorsScreen);
  }

  void openHelpFaq() {
    Get.back();
    // TODO: wire to Help & FAQ screen once designed
  }

  void logout() {
    Get.back();
    Get.offAllNamed(AppRoutes.signInScreen);
  }
}