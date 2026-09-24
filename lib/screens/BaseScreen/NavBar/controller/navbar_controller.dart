import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imusa04_landlord_app/screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/HomeScreen/home_screen.dart';
import '../../../../constant/const_icons.dart';
import '../../../../utils/app_role.dart';
import '../../../../utils/log_print.dart';
import '../../../UserScreen/LandlordAllScreen/PropertiesAllScreen/Properties/properties_list_screen.dart';
import '../../MessagesScreen/MessagesListScreen/messages_screen.dart';
import '../../ProfileAllScreen/profile_screen.dart';
import '../widgets/coming_soon_placeholder.dart';

class NavbarController extends GetxController {
  List<String> icons = [];
  List<String> labels = [];
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

  void onAppInitial() {
    switch (selectedUserRole) {
      case AppUserType.landlord:
        labels = const ['Home', 'Properties', 'Messages', 'Profile'];
        icons = const [
          ConstIcons.homeTabIcon,
          ConstIcons.propertiesTabIcon,
          ConstIcons.messagesTabIcon,
          ConstIcons.profileTabIcon,
        ];
        pages = const [
          HomeScreen(),
          PropertiesListScreen(),
          MessagesListScreen(),
          ProfileScreen(),
        ];
        break;

      case AppUserType.tenant:
        labels = const ['Home', 'Issues', 'Messages', 'Profile'];
        icons = const [
          ConstIcons.homeTabIcon,
          ConstIcons.issuesTabIcon,
          ConstIcons.messagesTabIcon,
          ConstIcons.profileTabIcon,
        ];
        pages = const [
          ComingSoonPlaceholder(label: 'Home'),
          ComingSoonPlaceholder(label: 'Issues'),
          MessagesListScreen(),
          ProfileScreen(),
        ];
        break;

      case AppUserType.contractor:
        labels = const ['Home', 'Jobs', 'Messages', 'Profile'];
        icons = const [
          ConstIcons.homeTabIcon,
          ConstIcons.jobsTabIcon,
          ConstIcons.messagesTabIcon,
          ConstIcons.profileTabIcon,
        ];
        pages = const [
          ComingSoonPlaceholder(label: 'Home'),
          ComingSoonPlaceholder(label: 'Jobs'),
          MessagesListScreen(),
          ProfileScreen(),
        ];
        break;
    }

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