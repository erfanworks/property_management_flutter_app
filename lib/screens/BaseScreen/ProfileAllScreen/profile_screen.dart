import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constant/const_color.dart';
import '../../../utils/app_role.dart';
import '../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../widget/text/custom_text.dart';
import 'Controller/profile_screen_controller.dart';
import 'Widget/profile_menu_header.dart';
import 'Widget/profile_section_card.dart';
import 'Widget/profile_user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileScreenController>(
      init: ProfileScreenController(),
      builder: (controller) {
        final bool isLandlord = selectedUserRole == AppUserType.landlord;

        return Scaffold(
          backgroundColor: ConstColor.screenBackground,
          appBar: isLandlord ? const GlobalAppBar(showBack: false, title: "Profile") : null,
          body: SafeArea(
            top: !isLandlord,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!isLandlord) const ProfileMenuHeader(title: "Profile"),
                  SizedBox(height: 12.h),
                  ProfileUserCard(
                    name: controller.userName,
                    subtitle: controller.userSubtitle,
                    badgeText: controller.userBadge,
                    onTap: controller.onUserCardTap,
                  ),
                  SizedBox(height: 20.h),
                  ...controller.sections.map((section) => ProfileSectionCard(section: section)),
                  CustomElevatedButton(
                    onPressed: controller.onLogOut,
                    isOutLined: true,
                    elevation: 0,
                    outLineColour: Colors.red,
                    child: CustomText(
                      title: "Log Out",
                      textColor: Colors.red,
                      textSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}