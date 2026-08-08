import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/nav_bar_bottom.dart';
import 'controller/navbar_controller.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(
      init: NavbarController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.pages,
          ),
          bottomNavigationBar: NavBarBottom(
            onTap: controller.onTapValueChange,
            icons: controller.icons,
            labels: controller.labels,
            selectedIndex: controller.selectedIndex.value,
          ),
        );
      },
    );
  }
}