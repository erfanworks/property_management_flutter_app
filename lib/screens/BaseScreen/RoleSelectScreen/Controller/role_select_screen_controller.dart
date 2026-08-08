import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../routes/app_routes/app_routes.dart';
import '../../../../utils/app_role.dart';

class RoleOption {
  final AppUserType type;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String subtitle;

  const RoleOption({
    required this.type,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}

class RoleSelectScreenController extends GetxController {
  final Rx<AppUserType> selectedRole = AppUserType.landlord.obs;

  final List<RoleOption> roles = const [
    RoleOption(
      type: AppUserType.landlord,
      icon: Icons.home_rounded,
      iconBgColor: ConstColor.landlordIconBg,
      iconColor: ConstColor.primaryColor,
      title: ConstString.landlordRole,
      subtitle: ConstString.landlordRoleSubtitle,
    ),
    RoleOption(
      type: AppUserType.tenant,
      icon: Icons.person_rounded,
      iconBgColor: ConstColor.tenantIconBg,
      iconColor: ConstColor.tenantIconColor,
      title: ConstString.tenantRole,
      subtitle: ConstString.tenantRoleSubtitle,
    ),
    RoleOption(
      type: AppUserType.contractor,
      icon: Icons.build_rounded,
      iconBgColor: ConstColor.contractorIconBg,
      iconColor: ConstColor.contractorIconColor,
      title: ConstString.contractorRole,
      subtitle: ConstString.contractorRoleSubtitle,
    ),
  ];

  String get selectedRoleLabel {
    switch (selectedRole.value) {
      case AppUserType.landlord:
        return ConstString.landlordRole;
      case AppUserType.tenant:
        return ConstString.tenantRole;
      case AppUserType.contractor:
        return ConstString.contractorRole;
    }
  }

  void onSelectRole(AppUserType role) => selectedRole.value = role;

  void onContinue() {
    selectedUserRole = selectedRole.value; // used by NavbarController to build correct tabs
    Get.toNamed(AppRoutes.signInScreen);
  }
}