import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/const_icons.dart';
import '../../../../utils/app_role.dart';
import '../../../../utils/log_print.dart';

class NavbarController extends GetxController {
  List<String> icons = [];
  List<Widget> pages = [];

  RxInt selectedIndex = 0.obs;

  void onTapValueChange(int index) {
    try {
      selectedIndex.value = index;
      update();
    } catch (e) {
      errorLog("onTapValueChange", e);
    }
  }

  void searchDestinationNavButton() {
    try {
      selectedIndex.value = 1;
      update();
      Future.delayed(Durations.medium4, () {
        // Get.put(SearchPageController()).requestFocusNode();
      });
    } catch (e) {
      errorLog("message", e);
    }
  }

  void onAppInitial() {
    // --- Pages Initialization ---
    pages = selectedUserRole == AppUserType.user
        ? [
            // const HomeScreen(),
            // const SavedPropertiesScreen(),
            // const EnquiriesScreen(),
            // const ProfileScreen(),
          ]
        : selectedUserRole == AppUserType.agent
        ? [
            // const Overviewhomescreen(),
            // const MyListingScreen(),
            // const AgentEnquiriesScreen(),
            // const ProfileScreen(),
          ]
        : [];

    // --- Icons Initialization ---
    icons = selectedUserRole == AppUserType.user
        ? [
            ConstIcons.homeTabIcon,
            ConstIcons.savedTabIcon,
            ConstIcons.enquiresTabIcon,
            ConstIcons.profileTabIcon,
          ]
        : selectedUserRole == AppUserType.agent
        ? [
            ConstIcons.overviewTabIcon,
            ConstIcons.listingTabIcon,
            ConstIcons.dashBoardTabIcon,
            ConstIcons.profileTabIcon,
          ]
        : [];

    // ─── FIXED: Force UI update whenever this is called ───
    update();
  }

  @override
  void onInit() {
    onAppInitial();
    if (Get.arguments != null && Get.arguments is int) {
      selectedIndex.value = Get.arguments as int;
    }
    super.onInit();
  }
}
