import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes/app_routes.dart';
import '../../../../utils/app_role.dart';
import '../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../Widget/profile_section_card.dart';

class ProfileScreenController extends GetxController {
  // ─── User header (dummy, role-based) ───
  String get userName {
    switch (selectedUserRole) {
      case AppUserType.landlord:
        return "John Smith";
      case AppUserType.tenant:
        return "Sarah Johnson";
      case AppUserType.contractor:
        return "Mike Thompson";
    }
  }

  String get userSubtitle {
    switch (selectedUserRole) {
      case AppUserType.landlord:
        return "Edit profile";
      case AppUserType.tenant:
        return "sarah.j@email.com";
      case AppUserType.contractor:
        return "Plumber Pro Ltd";
    }
  }

  String? get userBadge => selectedUserRole == AppUserType.tenant ? "Flat 2A" : null;

  void onUserCardTap() => _comingSoon("Edit Profile");

  // ─── Sections (role-based) ───
  List<ProfileSectionModel> get sections {
    switch (selectedUserRole) {
      case AppUserType.landlord:
        return _landlordSections;
      case AppUserType.tenant:
        return _tenantSections;
      case AppUserType.contractor:
        return _contractorSections;
    }
  }

  List<ProfileSectionModel> get _landlordSections => [
    ProfileSectionModel(items: [
      ProfileMenuItemModel(
          icon: Icons.notifications_none_rounded,
          title: "Notification Settings",
          onTap: () => _comingSoon("Notification Settings")),
      ProfileMenuItemModel(
          icon: Icons.tune_rounded, title: "Preferences", onTap: () => _comingSoon("Preferences")),
      ProfileMenuItemModel(
          icon: Icons.credit_card_outlined,
          title: "Payment Methods",
          onTap: () => _comingSoon("Payment Methods")),
      ProfileMenuItemModel(
          icon: Icons.vpn_key_outlined,
          title: "Change Password",
          onTap: () => _comingSoon("Change Password")),
      ProfileMenuItemModel(
          icon: Icons.receipt_long_outlined,
          title: "Transaction History",
          onTap: () => _comingSoon("Transaction History")),
      ProfileMenuItemModel(
          icon: Icons.diamond_outlined, title: "Subscription", onTap: () => _comingSoon("Subscription")),
    ]),
    ProfileSectionModel(header: "SUPPORT & LEGAL", items: [
      ProfileMenuItemModel(
          icon: Icons.help_outline_rounded,
          title: "Help & Support",
          onTap: () => _comingSoon("Help & Support")),
      ProfileMenuItemModel(icon: Icons.info_outline_rounded, title: "About", onTap: () => _comingSoon("About")),
      ProfileMenuItemModel(
          icon: Icons.shield_outlined, title: "Privacy Policy", onTap: () => _comingSoon("Privacy Policy")),
      ProfileMenuItemModel(
          icon: Icons.description_outlined,
          title: "Terms & Conditions",
          onTap: () => _comingSoon("Terms & Conditions")),
    ]),
  ];

  List<ProfileSectionModel> get _tenantSections => [
    ProfileSectionModel(
      header: "Your tenancy",
      subtitle: "Flat, documents and end-of-lease tasks.",
      items: [
        ProfileMenuItemModel(
            icon: Icons.home_outlined,
            title: "Active tenancy",
            subtitle: "12 Park Lane · Flat 2A",
            onTap: () => _comingSoon("Active tenancy")),
        ProfileMenuItemModel(
            icon: Icons.call_outlined,
            title: "Contact information",
            subtitle: "+44 7700 900456",
            onTap: () => _comingSoon("Contact information")),
        ProfileMenuItemModel(
            icon: Icons.assignment_outlined,
            title: "Tenant referencing",
            subtitle: "0/7 complete",
            onTap: () => _comingSoon("Tenant referencing")),
        ProfileMenuItemModel(
            icon: Icons.folder_outlined,
            title: "Documents",
            subtitle: "4 files",
            onTap: () => _comingSoon("Documents")),
        ProfileMenuItemModel(
            icon: Icons.exit_to_app_outlined,
            title: "Check-out",
            subtitle: "Deposit £2,450",
            onTap: () => _comingSoon("Check-out")),
      ],
    ),
    ProfileSectionModel(
      header: "Maintenance & landlord",
      subtitle: "Report issues and message your landlord.",
      items: [
        ProfileMenuItemModel(
            icon: Icons.handyman_outlined,
            title: "Maintenance requests",
            subtitle: "2 open",
            onTap: () => _comingSoon("Maintenance requests")),
        ProfileMenuItemModel(
            icon: Icons.chat_bubble_outline_rounded,
            title: "Your landlord",
            subtitle: "John Smith",
            onTap: () => _comingSoon("Your landlord")),
      ],
    ),
    ProfileSectionModel(
      header: "Your account",
      subtitle: "Sign-in, payments and notifications",
      items: [
        ProfileMenuItemModel(
            icon: Icons.notifications_none_rounded,
            title: "Notification settings",
            onTap: () => _comingSoon("Notification settings")),
        ProfileMenuItemModel(
            icon: Icons.vpn_key_outlined,
            title: "Change password",
            onTap: () => _comingSoon("Change password")),
        ProfileMenuItemModel(
            icon: Icons.security_outlined, title: "Security", onTap: () => _comingSoon("Security")),
        ProfileMenuItemModel(
            icon: Icons.receipt_long_outlined,
            title: "Payment history",
            subtitle: "Next Jul 1, 2026",
            onTap: () => _comingSoon("Payment history")),
        ProfileMenuItemModel(
            icon: Icons.campaign_outlined,
            title: "Announcements",
            onTap: () => _comingSoon("Announcements")),
      ],
    ),
    ProfileSectionModel(
      header: "Support & legal",
      subtitle: "Help centre and platform policies.",
      items: [
        ProfileMenuItemModel(icon: Icons.quiz_outlined, title: "FAQ", onTap: () => _comingSoon("FAQ")),
        ProfileMenuItemModel(
            icon: Icons.support_agent_outlined,
            title: "Help & Support",
            onTap: () => _comingSoon("Help & Support")),
        ProfileMenuItemModel(
            icon: Icons.info_outline_rounded,
            title: "About Landlord HQ",
            onTap: () => _comingSoon("About")),
        ProfileMenuItemModel(
            icon: Icons.shield_outlined, title: "Privacy Policy", onTap: () => _comingSoon("Privacy Policy")),
        ProfileMenuItemModel(
            icon: Icons.description_outlined,
            title: "Terms & Conditions",
            onTap: () => _comingSoon("Terms & Conditions")),
      ],
    ),
  ];

  List<ProfileSectionModel> get _contractorSections => [
    ProfileSectionModel(items: [
      ProfileMenuItemModel(
          icon: Icons.apartment_outlined,
          title: "Company Information",
          onTap: () => _comingSoon("Company Information")),
      ProfileMenuItemModel(
          icon: Icons.workspace_premium_outlined,
          title: "Certifications",
          onTap: () => _comingSoon("Certifications")),
      ProfileMenuItemModel(
          icon: Icons.notifications_none_rounded,
          title: "Alerts & Notifications",
          onTap: () => _comingSoon("Alerts & Notifications")),
      ProfileMenuItemModel(
          icon: Icons.vpn_key_outlined,
          title: "Change Password",
          onTap: () => _comingSoon("Change Password")),
    ]),
    ProfileSectionModel(header: "Support", items: [
      ProfileMenuItemModel(
          icon: Icons.help_outline_rounded,
          title: "Help & Support",
          onTap: () => _comingSoon("Help & Support")),
      ProfileMenuItemModel(
          icon: Icons.shield_outlined, title: "Privacy Policy", onTap: () => _comingSoon("Privacy Policy")),
      ProfileMenuItemModel(
          icon: Icons.description_outlined,
          title: "Terms & Conditions",
          onTap: () => _comingSoon("Terms & Conditions")),
      ProfileMenuItemModel(icon: Icons.info_outline_rounded, title: "About", onTap: () => _comingSoon("About")),
    ]),
  ];

  void _comingSoon(String label) => AppSnackBar.message("$label — coming soon");

  void onLogOut() {
    // TODO: clear session/token via StorageServices once implemented
    Get.offAllNamed(AppRoutes.signInScreen);
  }
}